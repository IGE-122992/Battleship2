FROM maven:3.9.6-eclipse-temurin-21 AS builder
WORKDIR /build
COPY pom.xml .
COPY src ./src
RUN mvn -B -DskipTests package

FROM eclipse-temurin:21-jre AS runtime
WORKDIR /app
COPY --from=builder /build/target/BattleshipGamePlayer-2.0.jar app.jar
RUN useradd -m appuser && chown -R appuser:appuser /app
USER appuser
ENTRYPOINT ["java","-jar","/app/app.jar"]
