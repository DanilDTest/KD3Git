PlatformPath="$1"
EPFPath="$2"
IBName="$3"
Usr="$4"
Pwd="$5"
LaunchParameter="$6"

if [ -z "$EPFPath" ]; then
  exit 1
fi


"$PlatformPath" ENTERPRISE //IBName"$IBName" //N"$Usr" //P"$Pwd" //C"$LaunchParameter" //DisableStartupMessages //DisableStartupDialogs //DisableSplash //WA+ //AU- //Execute "$EPFPath" 

