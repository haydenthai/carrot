REQUIRED_PKG="openjdk-11-jre-headless"
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")
echo Checking for $REQUIRED_PKG: $PKG_OK
if [ "" = "$PKG_OK" ]; then
	  echo "No $REQUIRED_PKG. Setting up $REQUIRED_PKG."
	  sudo apt --yes update
	  sudo apt --yes upgrade
	  sudo apt-get --yes install $REQUIRED_PKG 
fi

for i in `seq 1 1 12`; do ./seed > output$i.txt & done ; watch -gn 0.5 grep "Seed: " output*.txt; cat `grep -l "Seed: " *.txt`; killall ./seed; rm output*.txt
