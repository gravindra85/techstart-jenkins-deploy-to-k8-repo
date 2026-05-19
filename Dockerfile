FROM maven:3.9.6-amazoncorretto-21 AS builder
COPY . /usr/src/easybuggy/
WORKDIR /usr/src/easybuggy/
RUN mvn -B -DskipTests package

FROM tomcat:9.0-jdk21-temurin
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=builder /usr/src/easybuggy/target/ROOT.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
