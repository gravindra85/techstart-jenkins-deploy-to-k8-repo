FROM maven:3.9.6-amazoncorretto-21 AS builder
COPY . /usr/src/easybuggy/
WORKDIR /usr/src/easybuggy/
RUN mvn -B package

FROM amazoncorretto:21-alpine
COPY --from=builder /usr/src/easybuggy/target/easybuggy.jar /
CMD ["java", "-XX:MaxMetaspaceSize=128m", "-Xmx256m", "-XX:MaxDirectMemorySize=90m", "-XX:+UseSerialGC", "-jar", "easybuggy.jar"]
