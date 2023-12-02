# Étape 1: Utiliser une image de base avec Maven pour télécharger les dépendances
FROM maven:3.8.4-openjdk-17-slim as build
WORKDIR /usr/src/app
COPY pom.xml .
RUN mvn dependency:go-offline

# Étape 2: Copier le reste des fichiers et effectuer la construction
FROM maven:3.8.4-openjdk-17-slim
WORKDIR /usr/src/app
COPY --from=build /usr/src/app /usr/src/app
COPY . .
RUN mvn clean install

# Étape 3: Utiliser une image plus légère sans Maven pour exécuter l'application
FROM openjdk:17-slim
WORKDIR /usr/src/app
COPY --from=build /usr/src/app/target/mymvnproject-1.0-SNAPSHOT.jar .
CMD ["java", "-jar", "mymvnproject-1.0-SNAPSHOT.jar"]

