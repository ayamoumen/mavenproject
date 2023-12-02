# On utilise une image de base avec Java et Maven préinstallés
FROM maven:3.8.4-openjdk-17-slim as build

# On copie les fichiers de notre application dans le conteneur
COPY . /usr/src/app

# On définit le répertoire de travail
WORKDIR /usr/src/app

# On exécute la construction de l'application avec Maven
RUN mvn clean install

# On utilise une image légère avec Java pour exécuter l'application
FROM openjdk:17-slim
WORKDIR /usr/src/app

# On copie le fichier JAR généré lors de l'étape de construction précédente
COPY --from=build /usr/src/app/target/mymvnproject-1.0-SNAPSHOT.jar .

# On démarre l'application à partir du fichier .jar généré
CMD ["java", "-jar", "mymvnproject-1.0-SNAPSHOT.jar"]
