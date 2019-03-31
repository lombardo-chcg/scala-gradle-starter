# gradle + scala project starter

A utility to spawn fresh Gradle/Scala projects!  
- scala 2.12.8
- gradle 5.x
- dockerfile
- scalatest
- log4j

### How to use

1. Clone this project into a directory of your choosing.
2. Run the starter script with the name of your project as an argument (e.g. `./starter-cli/starter.sh myproject`).
3. By default your project will be created in a new directory which is a "sibling" of the project starter directory.


### Building

The starter script runs a `./gradlew shadowjar` as the last step in the setup. Additional builds, testing, and 
bundling can be had by running the following commands:
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
