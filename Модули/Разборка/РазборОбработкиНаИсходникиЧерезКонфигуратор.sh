ResCatalogPath=$1 ##Куда выгрузить результат разбора
EPFPath=$2 ##Обработка для разбора
LogPath=$3 
OneSPath=$4 

if [ -z "$EPFPath" ]; then
  exit 1
fi

cd "$OneSPath"
#./1cv8.exe DESIGNER //DumpExternalDataProcessorOrReportToFiles "D:\1с\Очоба\OS\test\TestUnpack\Res" "D:\1с\Очоба\OS\test\TestUnpack\T.epf" /Out "D:\1с\Очоба\OS\test\TestUnpack\Res\out.txt"
./1cv8.exe DESIGNER //DumpExternalDataProcessorOrReportToFiles $ResCatalogPath $EPFPath -Plain /Out $LogPath

