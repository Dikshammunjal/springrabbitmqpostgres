FROM openjdk:17-jdk as base
WORKDIR /app
 
COPY .mvn/ .mvn
COPY mvnw pom.xml ./
RUN chmod +x mvnw
RUN ./mvnw dependency:go-offline
COPY src ./src
 
#FROM base as test
#RUN ["./mvnw", "test"]
 
FROM base as build
RUN ["./mvnw", "package"]
 
#USER spring:spring
#ARG JAR_FILE=target/*.jar
 
#ADD ${JAR_FILE} app.jar
 
ENTRYPOINT ["java","-jar","--enable-preview", "-Dspring.profiles.active=ocidevops","target/SpringBootRabbitMQHelloWorld-0.0.1-SNAPSHOT.jar"]
