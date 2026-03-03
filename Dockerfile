# --- build ---
FROM maven:3.9.8-eclipse-temurin-21 AS build

WORKDIR /app

# pom.xml & sursele
COPY pom.xml .
COPY src ./src

# se ruleaza Maven pentru a genera JAR-ul
RUN mvn clean package -DskipTests

# --- runtime stage ---
FROM eclipse-temurin:17-jdk

WORKDIR /app

# copiem JAR-ul rezultat din build stage
COPY --from=build /app/target/*.jar app.jar

# expunem portul
EXPOSE 8080

# comanda de start
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
