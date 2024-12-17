# Use a Gradle image to build the project
FROM gradle:8.4-jdk21 AS builder

# Set the working directory
WORKDIR /app

# Copy Gradle files and project files to the container
COPY build.gradle settings.gradle gradlew ./
COPY gradle ./gradle
COPY src ./src

# Build the project and package it as a JAR file
RUN ./gradlew clean build -x test

# Use a lightweight JRE image to run the application
FROM eclipse-temurin:17-jre-alpine

# Set the working directory
WORKDIR /app

# Copy the built JAR file from the builder stage
COPY --from=builder /app/build/libs/*.jar app.jar

# Expose the application port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
