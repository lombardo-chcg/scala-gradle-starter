#!/usr/bin/env bash
set -eo pipefail

[[ $# -eq 0 ]] && {
  echo "ERROR Missing Argument: projectName"
  echo 'USAGE: ./starter-cli/starter.sh "myproject"'
}

projectName=$1

# Move to the parent, create the project directory, and cd in
cd .. && mkdir $projectName && cd $_

# Copy scala-gradle-starter into the project directory
cp -r ../scala-gradle-starter/ .
rm -rf .git
rm -rf starter-cli

# Update files for project name
# We use awk here instead of sed as it has better POSIX support
declare -a buildFiles=("build.gradle" 
                       "Dockerfile"
                       "src/main/scala/com/scala-gradle-starter/Main.scala"
                       "src/test/scala/com/scala-gradle-starter/SampleTest.scala")

for file in "${buildFiles[@]}"
do
  awk -v name="$projectName" 'gsub(/scala\-gradle\-starter/, name)1' "$PWD/$file" > "$PWD/${file}_tmp" \
    && mv -f "$PWD/${file}_tmp" "$PWD/$file"

done

# Rename source and test directories
mv src/main/scala/com/scala-gradle-starter "src/main/scala/com/$projectName"
mv src/test/scala/com/scala-gradle-starter "src/test/scala/com/$projectName"

# Eject the starter
rm -rf starter-cli

# Init git and make first commit
git init
git add .
git commit -m "Initialized $projectName"

# Run gradle with a build 
./gradlew shadowJar
