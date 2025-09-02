set +o history
source $(git rev-parse --show-toplevel)/Настройки/config.sh
source $gitCatPath/RepoConfig.sh

PathToOtherScripts=$gitKD3GitPath/Модули/Прочее
PlatformPath="/c/Program Files/1cv8/8.3.24.1691/bin/1cv8c.exe"
UnloadEPF="/d/Общая/ВыгрузитьАктуальныйМенеджерОбменаПР.epf"

EPFPath="$RulesUnloadDir"/"$RulesSyn"_Рабочие_$(date +%d_%m).epf
LaunchParameter="$EPFPath"

if $PathToOtherScripts/ЗапуститьОбработкуВПакетномРежиме.sh "$PlatformPath" "$UnloadEPF" "$IBName" "$Usr" "$Pwd" "$LaunchParameter"; then

    gitBranchName="Prod"
    commit="Загрузка рабочих правил"
    git switch -c $gitBranchName

    if "$PathToDisassemblyScripts/ОбновитьПравилаРазобравОбработку.sh" "$gitRepoName" "$gitBranchName" "$commit" "$EPFPath" "$gitKD3GitPath" "$gitCatPath" "$OneSPath"; then
    echo Ok
    fi
fi

