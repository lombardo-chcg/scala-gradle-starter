#!/usr/bin/env bash
set -eo pipefail

read -p "Enter project name: " projectName

projectNameMatcher='^[a-zA-Z0-9\-]$'
[[ $projectName =~ $projectNameMatcher ]] && {
  echo "Invalid project name.  Allowed characters are a-z, A-Z, 0-9 and hyphens.  ex: my-new-project"
  exit 1
}

[[ -f "../$projectName" ]] || [[ -d "../$projectName" ]] && {
  echo "File or directory already exists with that name: ../$projectName"
  echo "Choose another name or clear existing path and try again."
  exit 1
}

defaultPkg="com.starter"
read -p "Enter package name ($defaultPkg): " packageName
packageName=${packageName:-$defaultPkg}

packageNameMatcher='^[a-z][a-z0-9_]*(\.[a-z0-9_]+)+[0-9a-z_]$'
[[ $packageName =~ $packageNameMatcher ]] || {
  echo "Invalid package name.  Must be all-lowercase ASCII letters and cannot start with a reserved identifier."
  echo "e.g.: com.github.me, com.7up.you"
  exit 1
}

# Move to the parent, create the project directory, and cd in
cd .. && mkdir $projectName && cd $projectName
echo "creating new Scala Gradle project at $(pwd)"

# Copy scala-gradle-starter into the project directory
cp -r ../scala-gradle-starter/ .
rm -rf .git

## Update files for project name
## We use awk here instead of sed as it has better POSIX support
declare -a buildFiles=("build.gradle"
                       "Dockerfile"
                       "src/main/scala/com/starter/Main.scala")
#
for file in "${buildFiles[@]}"
do
  awk -v name="$projectName" 'gsub(/scala\-gradle\-starter/, name)1' "$PWD/$file" > "$PWD/${file}_tmp" \
    && mv -f "$PWD/${file}_tmp" "$PWD/$file"
done


## Update package name
declare -a srcFiles=("src/main/scala/com/starter/Main.scala"
                     "src/test/scala/com/starter/SampleTest.scala"
                     "build.gradle")
#
[[ "$packageName" -ne "$defaultPkg" ]] && {
  for file in "${srcFiles[@]}"
    do
      awk -v name="$packageName" 'gsub(/com\.starter/, name)1' "$PWD/$file" > "$PWD/${file}_tmp" \
        && mv -f "$PWD/${file}_tmp" "$PWD/$file"
    done

  # Rename source and test directories
  packageToPath=$(echo "$packageName" | tr '.' '/')
  mkdir -p "src/main/scala/$packageToPath"
  mkdir -p "src/test/scala/$packageToPath"
  mv src/main/scala/com/starter "src/main/scala/$packageToPath"
  mv src/test/scala/com/starter "src/test/scala/$packageToPath"
}

## Eject the starter
rm -rf starter-cli

## Init git and make first commit
git init
git add .
git commit -m "Initialized $projectName"

## Run gradle with a build
./gradlew check run

echo -e "\nSuccess!  Project created.\n"
echo "'cd ../$projectName' to begin using it."