ResCatalogPath=$1 ##Исходники обработки для сборки
EPFPath=$2 ##Путь к собранной обработке
LogPath=$3 
OneSPath=$4 

cd "$OneSPath"
./1cv8.exe DESIGNER //LoadExternalDataProcessorOrReportFromFiles $ResCatalogPath $EPFPath -Plain /Out$LogPath 

