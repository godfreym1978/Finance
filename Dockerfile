FROM maven:3.6.3-openjdk-8 as buildprobe
RUN git clone https://github.com/godfreym1978/Finance && cd Finance
WORKDIR /Finance
RUN mvn package && ls -l /Finance && ls -l /Finance/target

FROM tomcat:9.0.21-jdk8-openjdk
COPY --from=buildprobe /Finance/target/*.war /usr/local/tomcat/webapps/Finance.war
