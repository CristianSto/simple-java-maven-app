# --- build ---
FROM maven:3.8.5-openjdk-17 AS build

WORKDIR /app

# pom.xml & sursele
COPY pom.xml .
COPY src ./src

# se ruleaza Maven pentru a genera JAR-ul
RUN mvn clean package -DskipTests

# --- runtime stage ---
FROM openjdk:17-jdk-slim

WORKDIR /app

# copiem JAR-ul rezultat din build stage
COPY --from=build /app/target/*.jar app.jar

# expunem portul
EXPOSE 8080

# comanda de start
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
