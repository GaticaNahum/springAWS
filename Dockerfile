# Utiliza una imagen de Maven como base para la etapa de compilación
FROM maven:3.8.4-openjdk-17 AS builder

# Establece el directorio de trabajo en /app
WORKDIR /app

# Copia el archivo pom.xml y el código fuente
COPY pom.xml .
COPY src ./src

# Empaqueta la aplicación en un archivo JAR
RUN mvn clean package

# Utiliza una imagen de Java 17 como base para la etapa de ejecución
FROM openjdk:17.0.2-jdk

# Copia el archivo JAR generado desde el contenedor de compilación
COPY --from=builder /app/target/spring-test-0.0.1-SNAPSHOT.jar /app.jar

# Expone el puerto en el que se ejecuta tu aplicación
EXPOSE 8080

# Comando para ejecutar la aplicación cuando se inicie el contenedor
CMD ["java", "-jar", "/app.jar"]
