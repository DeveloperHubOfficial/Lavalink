# Use an official OpenJDK runtime as a parent image
FROM openjdk:17-jdk-alpine

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Make sure gradlew is executable
RUN chmod +x ./gradlew

# Build the Lavalink JAR
RUN ./gradlew shadowJar

# Expose the port
EXPOSE ${PORT}

# Run the Lavalink server
CMD ["java", "-Dserver.port=${PORT}", "-jar", "build/libs/Lavalink.jar"]
