FROM maven:3.5-jdk-8 as BUILD
COPY * /usr/src/myapp/src/
RUN mvn -f /usr/src/myapp/src/pom.xml clean package


