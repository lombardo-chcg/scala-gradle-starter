# gradle/scala project starter

Basic scaffolding for a Scala project built with Gradle.

### How to use

Execute the following commands to customize the project's base name.  Will not rename classes or packages in the project code.  
*TODO: enable automated renaming of packages and classes too*

```
projectName="my-project"
mkdir $projectName
cd $projectName
git clone https://github.com/lombardo-chcg/scala-gradle-starter.git
cp -r scala-gradle-starter/ .
rm -rf scala-gradle-starter/
rm -rf .git
sed -i "" "s/scala-gradle-starter/$projectName/g" build.gradle
sed -i "" "s/scala-gradle-starter/$projectName/g" Dockerfile
git init
git add .
git commit -m "initialize $projectName"
```


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
