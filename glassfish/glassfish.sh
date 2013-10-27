#!/bin/bash


GF_UNZIP_TARGET="/opt/"
ASADMIN="${GF_UNZIP_TARGET}glassfish4/bin/asadmin"
PASSWORD_FILE="/tmp/password.file"

bootstrap_system() {
	sudo apt-get -y -q update
	sudo apt-get -y -q install unzip vim openjdk-7-jre 
}

glassfish_setup() {
	# Changes default password to "vagrant" for admin
	echo "AS_ADMIN_PASSWORD=" > $PASSWORD_FILE
	echo "AS_ADMIN_NEWPASSWORD=vagrant" >> $PASSWORD_FILE
	$ASADMIN --user admin --passwordfile $PASSWORD_FILE start-domain
	$ASADMIN --user admin --passwordfile $PASSWORD_FILE change-admin-password
	# Update the password file with fresh password
	echo "AS_ADMIN_PASSWORD=vagrant" > $PASSWORD_FILE
}

glassfish_restart() {
	$ASADMIN --user admin --passwordfile $PASSWORD_FILE stop-domain
	$ASADMIN --user admin --passwordfile $PASSWORD_FILE start-domain
}

glassfish_enable_secure_admin() {
	# Secure admin makes admin interface remotely accessible and encrypts all admin traffic
	$ASADMIN --user admin --passwordfile $PASSWORD_FILE enable-secure-admin
	glassfish_restart
}

get_glassfish() {
	GF_FILE_NAME="glassfish-4.0.zip"
	GF_WEB_LINK="http://download.java.net/glassfish/4.0/release/${GF_FILE_NAME}"
	TEMP_LOCATION=/tmp/${GF_FILE_NAME}
	# See if file is provided
	if [ -f /vagrant/${GF_FILE_NAME} ]
	then
		# Copy the file
		cp /vagrant/${GF_FILE_NAME} ${TEMP_LOCATION}
	else
		# Download the file
		wget -cq ${GF_WEB_LINK} -O ${TEMP_LOCATION}	
	fi
}

unpack_glassfish() {
	unzip /tmp/glassfish-4.0.zip -d ${GF_UNZIP_TARGET}
}

remove_password_file() {
	rm -f $PASSWORD_FILE
}

bootstrap_system
get_glassfish
unpack_glassfish
glassfish_setup
glassfish_enable_secure_admin
remove_password_file
