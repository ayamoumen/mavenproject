# On utilise une image de base avec Java et Maven préinstallés
FROM maven:3.8.4-openjdk-17-slim

# On copie les fichiers de notre application dans le conteneur
COPY . /usr/src/app

# On définit le répertoire de travail
WORKDIR /usr/src/app

# On exécute la construction de l'application avec Maven
RUN mvn clean install

# On démarre l'application à partir du fichier .jar généré
CMD ["java", "-jar", "target/mymvnproject-1.0-SNAPSHOT.jar"]


