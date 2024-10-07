# Use an official OpenJDK runtime as a parent image
FROM openjdk:17-jdk-slim

# Set the working directory to /app
WORKDIR /app

# Install necessary tools to download files and parse JSON
RUN apt-get update && apt-get install -y wget jq \
    && rm -rf /var/lib/apt/lists/*

# Fetch the latest release tag from GitHub API and download Lavalink.jar
RUN LATEST_VERSION=$(wget -qO- https://api.github.com/repos/freyacodes/Lavalink/releases/latest | jq -r '.tag_name') && \
    wget https://github.com/freyacodes/Lavalink/releases/download/${LATEST_VERSION}/Lavalink.jar

# Copy the application.yml configuration file into the container
COPY LavalinkServer/application.yml /app

# Expose the port (for documentation purposes)
EXPOSE 2333

# Set the environment variable for the server port
ENV SERVER_PORT=${PORT}

# Run the Lavalink server
CMD ["sh", "-c", "java -Djdk.tls.client.protocols=TLSv1.1,TLSv1.2 -Dserver.port=$SERVER_PORT -jar Lavalink.jar"]
