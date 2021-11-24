FROM tomcat:8.5.73-jdk8

ADD ./web /usr/local/tomcat/webapps/ROOT
ADD ./ojdbc8.jar /usr/local/tomcat/lib/ojdbc8.jar

CMD ["catalina.sh", "run"]