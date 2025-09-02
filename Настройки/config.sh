# Сначала загружаем персональные настройки разработчика
if [ -f "Настройки/config.local.sh" ]; then
    source "Настройки/config.local.sh"
else
    echo "Создайте config.local.sh на основе Шаблоны/template_config_local.sh"
    exit 1
fi

initialDir="$(pwd)"
gitRepoPath=$(git rev-parse --show-toplevel)
gitRepoName=$(basename $gitRepoPath)

if [ "$gitRepoName" == "KD3Git" ];  then
	#Сабмодуль, репозиторий скриптов в репозитории правил
	isKD3GitRep=true
	gitKD3GitPath=$gitRepoPath ##Путь к репозиторию KD3Git/Репозиторий в репозитории

	gitRepoName=$(basename "$(git -C "$gitRepoPath/.." rev-parse --show-toplevel)")
    gitCatPath=$(git -C "$gitRepoPath/.." rev-parse --show-toplevel) ##Каталог репозитория правил || gitRepoPath
    
else
	#Скрипты скопированны , внешний реп
	isKD3GitRep=false	
	gitKD3GitPath="$gitHome/KD3Git" ##Путь к репозиторию KD3Git/Вынести в общие настройки
    gitCatPath="$gitHome/$gitRepoName" ##Каталог репозитория правил || gitRepoPath
fi

PathToDisassemblyScripts="$gitKD3GitPath/Модули/Разборка"
PathToRepoEditScripts="$gitKD3GitPath/Модули/РаботаСРепозиторием"
PathToAssemblyScripts="$gitKD3GitPath/Модули/Сборка"