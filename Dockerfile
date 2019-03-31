FROM openjdk:8-jre-slim

ADD build/libs/scala-gradle-starter-all.jar /usr/local/scala-gradle-starter-all.jar

CMD ["java", "-jar", "/usr/local/scala-gradle-starter-all.jar"]
