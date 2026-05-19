FROM maven:3.9.6-amazoncorretto-21 AS builder
COPY . /usr/src/easybuggy/
WORKDIR /usr/src/easybuggy/
RUN mvn -B package

FROM amazoncorretto:21-alpine
COPY --from=builder /usr/src/easybuggy/target/easybuggy.jar /
#CMD ["java", "-XX:MaxMetaspaceSize=128m", "-Xlog:gc*,gc+age=trace:file=logs/gc_%p_%t.log:time,uptime,pid:filecount=5,filesize=10M", "-Xmx256m", "-XX:MaxDirectMemorySize=90m", "-XX:+UseSerialGC", "-XX:+HeapDumpOnOutOfMemoryError", "-XX:HeapDumpPath=logs/", "-XX:ErrorFile=logs/hs_err_pid%p.log", "-agentlib:jdwp=transport=dt_socket,server=y,address=9009,suspend=n", "-Dderby.stream.error.file=logs/derby.log", "-Dderby.infolog.append=true", "-Dderby.language.logStatementText=true", "-Dderby.locks.deadlockTrace=true", "-Dderby.locks.monitor=true", "-Dderby.storage.rowLocking=true", "-Dcom.sun.management.jmxremote", "-Dcom.sun.management.jmxremote.port=7900", "-Dcom.sun.management.jmxremote.ssl=false", "-Dcom.sun.management.jmxremote.authenticate=false", "-ea", "-jar", "easybuggy.jar"]
CMD ["java", "-XX:MaxMetaspaceSize=128m", "-Xmx256m", "-XX:MaxDirectMemorySize=90m", "-XX:+UseSerialGC", "-jar", "easybuggy.jar"]
