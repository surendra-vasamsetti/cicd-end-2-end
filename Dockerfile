##artifact build stage
FROM maven AS buildstage
RUN mkdir /opt/cicd-end-2-end
WORKDIR /opt/cicd-end-2-end
COPY . .
RUN mvn clean install    ## artifact -- .war

### tomcat deploy stage
FROM tomcat
WORKDIR webapps
COPY --from=buildstage /opt/cicd-end-2-end/target/*.war .
RUN rm -rf ROOT && mv *.war ROOT.war
EXPOSE 8080
