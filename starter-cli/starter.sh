#!/usr/bin/env bash
set -eo pipefail

[[ $# -eq 0 ]] && {
  echo "ERROR Missing Argument: projectName"
  echo 'USAGE: ./starter-cli/starter.sh "myproject"'
  exit 1
}

projectName="$1"

validNameMatcher='[^a-zA-Z0-9\-]'
if [[ $projectName =~ $validNameMatcher ]]; then
  echo "Invalid project name.  Allowed characters are a-z, A-Z, 0-9, hyphens and underscores.  ex: my-new-project"
  echo "you entered: '$projectName'"
  exit 1
fi

[[ -f "../$projectName" ]] || [[ -d "../$projectName" ]] && {
  echo "File or directory already exists with that name: ../$projectName"
  echo "Choose another name or clear existing path and try again."
  exit 1
}

# Move to the parent, create the project directory, and cd in
cd .. && mkdir $projectName && cd $projectName
echo "creating new scala gradle project at $(pwd)"

# Copy scala-gradle-starter into the project directory
cp -r ../scala-gradle-starter/ .
rm -rf .git

## Update files for project name
## We use awk here instead of sed as it has better POSIX support
declare -a buildFiles=("build.gradle"
                       "Dockerfile")
#
for file in "${buildFiles[@]}"
do
  awk -v name="$projectName" 'gsub(/scala\-gradle\-starter/, name)1' "$PWD/$file" > "$PWD/${file}_tmp" \
    && mv -f "$PWD/${file}_tmp" "$PWD/$file"

done

## Eject the starter
rm -rf starter-cli
#
## Init git and make first commit
git init
git add .
git commit -m "Initialized $projectName"
#
## Run gradle with a build
./gradlew check

echo ""
echo "Success!  Project created"
echo "'cd ../$projectName' to begin using it."