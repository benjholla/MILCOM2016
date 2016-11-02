LoginSideChannels
=================

The LoginSideChannels project is a Java Server Page (JSP) web app vulnerable to various side channel attacks. Try to audit the `LoginSideChannels.war` application binary for vulnerabilities.

The binary of this application can be analyzed using [Atlas](http://www.ensoftcorp.com/atlas/) with the [AtlasWBP](https://github.com/benjholla/AtlasWBP) plugin frontend. It is not necessary to run this application unless you wish to perform dynamic analysis.

While it is not necessary to complete the lab you may also find the following Atlas Toolboxes of use.

- [Toolbox Commons](https://github.com/EnSoftCorp/toolbox-commons)
- [Jimple Toolbox Commons](https://github.com/EnSoftCorp/jimple-toobox-commons)
- [Slicing Toolbox](https://github.com/EnSoftCorp/slicing-toolbox)

## Runtime Requirements
This application requires a MySQL server.  The web application assumes the MySQL server is running on the localhost at port 3306.  The app connects to the server with the username "root" and the password "badpass".  These details can be changed in the Database.java class.

This app was tested using Java 7 and Tomcat 7 on Ubuntu and OSX.  You will need a JSP translator such as Tomcat to run this application.

## Deployment
### Installing Tomcat
#### Step 1) 

Download the core Tomcat 7 distribution from [https://tomcat.apache.org/](https://tomcat.apache.org/).

#### Step 2) 

Unzip and move contents to the location where you would like to run Tomcat.

`tar xvzf apache-tomcat-7.0.55.tar.gz`

`sudo mv apache-tomcat-7.0.55 /opt/tomcat`

#### Step 3) 
Set the file permissions.  Tomcat files need to be readable and scripts need to be executable.

`sudo chown -R <your_username_here> /opt/tomcat`

`sudo chmod +x /opt/tomcat/bin/*.sh`

#### Step 4) 

Test the Tomcat installation.

Run `/opt/tomcat/bin/startup.sh` to startup the Tomcat server.  Navigate to [http://localhost:8080](http://localhost:8080).  If Tomcat is properly installed you should see a Tomcat welcome page.  Once you know the installation is working you can shutdown the server with the `/opt/tomcat/bin/shutdown.sh` script.
