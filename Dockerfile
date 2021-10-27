FROM maven:3.5-jdk-8 as BUILD
COPY * /usr/src/myapp/src/
RUN mvn -f /usr/src/myapp/src/pom.xml clean package

FROM tomcat:7.0
COPY --from=BUILD /usr/src/myapp/target/*.war /usr/local/tomcat/webapps/Finance.war
ENV TZ=America/Los_Angeles
EXPOSE 8080
