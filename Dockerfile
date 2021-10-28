FROM alpine/git as clone
WORKDIR /app
RUN git clone https://github.com/godfreym1978/Finance.git

FROM maven:3.5-jdk-8-alpine as build
WORKDIR /app
COPY –from=clone /app/Finance /app
RUN mvn clean install package

FROM tomcat:8-jre8-alpine
#WORKDIR /app
COPY –from=build /app/webapp/target/webapp.war $CATALINA_HOME/webapps
EXPOSE 8080
