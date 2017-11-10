# gradle/scala project starter

Basic scaffolding for a Scala project built with Gradle.

### Run
```
./gradlew clean test
./gradlew clean run
```

### Build Docker Image
```
./gradlew clean shadowJar
docker build -t gradle-scala-starter .
docker run gradle-scala-starter:latest
```