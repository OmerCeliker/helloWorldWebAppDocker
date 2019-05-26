FROM openjdk:8-jdk-alpine
VOLUME /tmp
COPY /var/lib/jenkins/workspace/helloWorldWebAppDocker_master@2/target/gs-spring-boot-0.1.0.jar  app.jar
EXPOSE 8083
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar", "--server.port=8083"]
