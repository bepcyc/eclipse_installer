#original source: http://askubuntu.com/questions/26632/how-to-install-eclipse/219974#219974
#download eclipse here: http://www.eclipse.org/downloads/

if [ "$1" != "--quiet" ]
then
	VERBOSE=1
fi

#output only in verbose mode
log() {
	if [ -n "$VERBOSE" ]
	then 
		echo "$@"
	fi
}

log_error() {
	echo "$@" 1>&2
}

#check errors and exit if found
check_error() {
	if [ $? -ne 0 ]
	then
		ERROR=$?
		if [ -z "$1" ]
		then
			log_error "An error occured. Aborting installation. Error code: ($ERROR)"
		else
			#custom error message
			log_error "$@"
		fi
		exit $ERROR
	fi
}


FILE_MASK="eclipse*linux*.tar.gz"
DISTRO_COUNTER=$(ls -l $FILE_MASK|wc -l)
if [ $DISTRO_COUNTER -ne 1 ]
then
	log_error "Please leave only one Eclipse distribution in current directory and restart the script."
	exit 1
fi
FILE_NAME=$(ls $FILE_MASK)
log "Found distribution file of Eclipse: $FILE_NAME"
log "Extracting files from archive..."
tar -xzf $FILE_NAME
check_error
log "Moving Eclipse to system directory..."
sudo mv eclipse /opt/
check_error
log "Changing owner of Eclipse directory"
sudo chown -R root:$USER /opt/eclipse
check_error
log "Changing attributes of Eclipse directory"
sudo chmod -R +r /opt/eclipse
check_error
log "Creating execution script"
sudo touch /usr/bin/eclipse
check_error
sudo chmod 755 /usr/bin/eclipse
check_error
sudo tee /usr/bin/eclipse > /dev/null << EOF
#!/bin/sh    
export ECLIPSE_HOME="/opt/eclipse"
\$ECLIPSE_HOME/eclipse \$*
EOF
check_error


#workaround for a bug with menu in Unity in Ubuntu 13.10
IS_UBUNTU_1310=$(lsb_release -r 2>>/dev/null | grep 13\\.10)
[ -n "${IS_UBUNTU_1310}" ] && UBUNTU_MENU_WORKAROUND="env UBUNTU_MENU_PROXY=0 "

log "Creating .desktop file"
sudo tee /usr/share/applications/eclipse.desktop > /dev/null << EOF
[Desktop Entry]
Encoding=UTF-8
Name=Eclipse
Comment=Eclipse IDE
Exec=${UBUNTU_MENU_WORKAROUND}eclipse
Icon=/opt/eclipse/icon.xpm
Terminal=false
Type=Application
Categories=GNOME;Application;Development;
StartupNotify=true
EOF
check_error

echo -e "Installation complete.\nRun eclipse with the command:\n /usr/bin/eclipse -clean &"
