# gradle + scala project starter
![travis status](https://travis-ci.com/lombardo-chcg/scala-gradle-starter.svg?branch=master)

A utility to spawn fresh Gradle/Scala projects

- scala 2.12.8
- gradle wrapper 4.10.2 
- dockerfile
- scalatest
- log4j2

### How to use

1. Clone this project into a directory of your choosing.
2. Run the starter script and follow prompts. A new Scala project will be created in a new local directory.
3. Liftoff 🚀


### Building

The starter script runs a few `./gradlew` tasks as the last step in the setup. Additional builds, testing, and 
bundling can be had by running the following `./gradlew` tasks:
```
# Run tests
./gradlew clean test

# Bundle the project
./gradlew clean shadowjar

# Run the project
./gradlew clean run
```

### Build Docker Image
```
# Build the bundled jar
./gradlew clean shadowJar

# Build the docker image and tag it with your project name (e.g. myproject)
docker build -t myproject .

# Run the docker image
docker run myproject:latest
```
