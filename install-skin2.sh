##############################################
#             INSTALL SKIN RNSE              #
##############################################
#if [ -e /boot/skin.rnse*.zip ]; then
if [ -e /home/pi/skin.rnse*.zip ]; then
	rm -r /home/pi/.kodi/addons/skin.rns*
	unzip /boot/skin.rnse*.zip -d /home/pi/.kodi/addons/ > /dev/null 2>&1
	sed -i -e '$i \  <addon optional="true">skin.rnse</addon>' /usr/share/kodi/system/addon-manifest.xml
	sed -i -e 's/lookandfeel.skin" default="true">skin.estuary/lookandfeel.skin">skin.rnse/' /home/pi/.kodi/userdata/guisettings.xml
	sed -i -e 's/skin.rnsd/skin.rnse/' /home/pi/.kodi/userdata/guisettings.xml
else
	whiptail --title "ERROR SKIN RNS-D or RNS-E" --msgbox "NOT found skin on SD card in /boot/ \nskin.rnsd-*.zip or skin.rnse-*.zip" 10 60
fi
####
echo "---------------------------------------------------------"
echo "CREATING MEDIA FOLDER"
echo "---------------------------------------------------------"
mkdir /home/pi/movies /home/pi/music /home/pi/mults /home/pi/clips > /dev/null 2>&1
chmod -R 0777 /home/pi/movies /home/pi/music /home/pi/mults /home/pi/clips > /dev/null 2>&1
##############################################
#                SETTINGS KODI               #
##############################################
echo "---------------------------------------------------------"
echo "PRESETTING KODI"
echo "---------------------------------------------------------"
cat <<'EOF' > /home/pi/.kodi/userdata/sources.xml
<sources>
    <programs>
        <default pathversion="1"></default>
    </programs>
    <video>
        <default pathversion="1"></default>
        <source>
            <name>movies</name>
            <path pathversion="1">/home/pi/movies/</path>
            <allowsharing>true</allowsharing>
        </source>
        <source>
            <name>clips</name>
            <path pathversion="1">/home/pi/clips/</path>
            <allowsharing>true</allowsharing>
        </source>
        <source>
            <name>mults</name>
            <path pathversion="1">/home/pi/mults/</path>
            <allowsharing>true</allowsharing>
        </source>
    </video>
    <music>
        <default pathversion="1"></default>
        <source>
            <name>music</name>
            <path pathversion="1">/home/pi/music/</path>
            <allowsharing>true</allowsharing>
        </source>
    </music>
    <pictures>
        <default pathversion="1"></default>
    </pictures>
    <files>
        <default pathversion="1"></default>
        <source>
            <name>192.168.0.3</name>
            <path pathversion="1">smb://192.168.0.3/</path>
            <allowsharing>true</allowsharing>
        </source>
        <source>
            <name>pi</name>
            <path pathversion="1">/home/pi/</path>
            <allowsharing>true</allowsharing>
        </source>
    </files>
    <games>
        <default pathversion="1"></default>
    </games>
</sources>
EOF
chown pi:pi /home/pi/.kodi/userdata/sources.xml

# Disable Screensaver
sed -i 's/id="screensaver.mode" default="true">screensaver.xbmc.builtin.dim/id="screensaver.mode">/' /home/pi/.kodi/userdata/guisettings.xml

# Enable auto play next video
sed -i 's/id="videoplayer.autoplaynextitem" default="true">/id="videoplayer.autoplaynextitem">0,1,2,3,4/' /home/pi/.kodi/userdata/guisettings.xml

# Amplifi volume up to 30.0dB
sed -i 's/volumeamplification>0.000000/volumeamplification>30.000000/' /home/pi/.kodi/userdata/guisettings.xml

# Enable web-server
sed -i 's/id="services.webserverauthentication" default="true">true/id="services.webserverauthentication">false/' /home/pi/.kodi/userdata/guisettings.xml
sed -i 's/id="services.webserver" default="true">false/id="services.webserver">true/' /home/pi/.kodi/userdata/guisettings.xml
