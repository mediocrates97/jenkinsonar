# Use a base image
FROM openjdk:11-jre-slim

# Set the working directory
WORKDIR /app

# Copy the application JAR file
COPY target/myapp.jar myapp.jar

# Command to run the application
ENTRYPOINT ["java", "-jar", "myapp.jar"]
