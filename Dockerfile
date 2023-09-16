# Use an OpenJDK base image
FROM openjdk:11-jdk-slim
# Set the working directory within the container
WORKDIR /app
# Clone the Spring PetClinic repository
RUN apt-get update && \
    apt-get install -y git && \
    git clone https://github.com/imsimranmohanty/spring-framework-new.git
# Build the Spring PetClinic application
WORKDIR /app/spring-framework-petclinic
# Expose the port that the application will run on
EXPOSE 8080
# Set the startup command
CMD ["java", "-jar", "target/spring-petclinic-*.jar"]