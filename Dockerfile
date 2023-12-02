# Utiliser une image de base avec Maven et Java
FROM maven:3.8.4-openjdk-17-slim as build
WORKDIR /usr/src/app
COPY . .
RUN mvn clean install

# Utiliser une image légère avec Java pour exécuter l'application
FROM openjdk:17-slim
WORKDIR /usr/src/app
COPY --from=build /usr/src/app/target/mymvnproject-1.0-SNAPSHOT.jar .
CMD ["java", "-jar", "mymvnproject-1.0-SNAPSHOT.jar"]
