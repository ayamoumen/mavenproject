# Utilisez une image Maven pour construire l'application
FROM maven:3.8.4-openjdk-17-slim AS build

# Définissez le répertoire de travail
WORKDIR /usr/src/app

# Copiez le fichier POM et le fichier source
COPY pom.xml .
COPY src src

# Construisez l'application avec Maven
RUN mvn clean install

# Utilisez une image OpenJDK légère pour l'exécution
FROM openjdk:17-slim

# Définissez le répertoire de travail
WORKDIR /usr/src/app

# Copiez le fichier JAR depuis l'étape de construction
COPY --from=build /usr/src/app/target/mymvnproject-1.0-SNAPSHOT.jar .

# Commande pour exécuter l'application
CMD ["java", "-jar", "mymvnproject-1.0-SNAPSHOT.jar"]

