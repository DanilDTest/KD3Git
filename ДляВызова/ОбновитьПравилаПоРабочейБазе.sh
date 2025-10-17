set +o history
source $(git rev-parse --show-toplevel)/Настройки/config.sh
source $gitCatPath/RepoConfig.sh

PathToOtherScripts=$gitKD3GitPath/Модули/Прочее
PlatformPath="/c/Program Files/1cv8/8.3.24.1691/bin/1cv8c.exe"
UnloadEPF="/d/Общая/ВыгрузитьАктуальныйМенеджерОбменаПР.epf"

EPFPath="$RulesUnloadDir"/"$RulesSyn"_Рабочие_$(date +%d_%m).epf
LaunchParameter="$EPFPath"

# Создаем папку Ignore и файл-маркер для отслеживания выгрузки
mkdir -p "$gitCatPath/Ignore" 2>/dev/null
MarkerFile="$gitCatPath/Ignore/выгрузка_marker_$$.tmp"
touch "$MarkerFile"

if $PathToOtherScripts/ЗапуститьОбработкуВПакетномРежиме.sh "$PlatformPath" "$UnloadEPF" "$IBName" "$Usr" "$Pwd" "$LaunchParameter"; then

    # Ждем появления нового файла выгрузки (максимум 90 секунд)
    echo "Ожидание завершения выгрузки правил..."
    TIMEOUT=90
    ELAPSED=0
    while [ $ELAPSED -lt $TIMEOUT ]; do
        if [ -f "$EPFPath" ] && [ "$EPFPath" -nt "$MarkerFile" ]; then
            echo "Выгрузка завершена: $EPFPath"
            break
        fi
        sleep 1
        ELAPSED=$((ELAPSED + 1))
    done

    # Проверяем успешность ожидания
    if [ $ELAPSED -ge $TIMEOUT ]; then
        echo "Ошибка: таймаут ожидания выгрузки правил (90 сек)"
        rm -f "$MarkerFile"
        exit 1
    fi

    # Удаляем маркер
    rm -f "$MarkerFile"

    gitBranchName="Prod"
    commit="Загрузка рабочих правил"
    git switch -c $gitBranchName

    if "$PathToDisassemblyScripts/ОбновитьПравилаРазобравОбработку.sh" "$gitRepoName" "$gitBranchName" "$commit" "$EPFPath" "$gitKD3GitPath" "$gitCatPath" "$OneSPath"; then
    echo Ok
    fi
fi

