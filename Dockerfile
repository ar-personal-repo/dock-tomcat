FROM amazonlinux:latest
RUN yum -y update
ARG tomcat_version=11.0.1
RUN yum install -y java wget shadow-utils tar
RUN groupadd tomcat && mkdir /opt/tomcat
RUN useradd -s /bin/nologin -g tomcat -d /opt/tomcat tomcat
WORKDIR /opt
COPY ./apache-tomcat-11.0.1/ /opt/tomcat/
RUN cd /opt/tomcat && chgrp -R tomcat conf
RUN chmod g+rwx /opt/tomcat/conf && chmod g+r /opt/tomcat/conf/*
RUN chown -R tomcat /opt/tomcat/logs/ /opt/tomcat/temp /opt/tomcat/webapps /opt/tomcat/work
RUN chgrp -R tomcat /opt/tomcat/bin && chgrp -R tomcat /opt/tomcat/lib && chmod g+rwx /opt/tomcat/bin && chmod g+r /opt/tomcat/bin/*
WORKDIR /opt/tomcat/webapps
COPY ./webapp/tomcat10-jakartaee9/src/main/webapp/ /opt/tomcat/webapps/
#RUN wget https://tomcat.apache.org/tomcat-7.0-doc/appdev/sample/sample.war
EXPOSE 8080
CMD ["/opt/tomcat/bin/catalina.sh","run"]
