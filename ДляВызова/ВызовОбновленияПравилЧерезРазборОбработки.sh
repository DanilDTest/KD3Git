set +o history
source $(git rev-parse --show-toplevel)/Настройки/config.sh

gitBranchName="$DevelopmentBranchName"
commit="Обновление правил $gitRepoName"

cd "$RulesCatPath"

echo "Обработка для разбора"

# 1. Читаем вывод команды построчно и сохраняем в массив file_list
mapfile -t file_list < <(find . -type d -name "Рабочие" -prune -o -type f -name "*.epf" -print0 | xargs -0 -r ls -t | head -n 10)

# 2. Передаем массив в select. 
# Конструкция "${file_list[@]}" с кавычками гарантирует, что пробелы внутри имен файлов не разорвут строку.
select fname in "${file_list[@]}"; do
    if [ -n "$fname" ]; then
        EPFPath="$RulesCatPath/$fname"
        break;
    else
        echo "Неверный выбор. Пожалуйста, попробуйте снова."
    fi
done

read -e -p 'branch: ' -i "$gitBranchName" gitBranchName
read -e -p 'Текст коммита(номер запроса): ' -i "$commit" commit

"$PathToDisassemblyScripts/ОбновитьПравилаРазобравОбработку.sh" "$gitRepoName" "$gitBranchName" "$commit"  "$EPFPath" "$gitKD3GitPath" "$gitCatPath" "$OneSPath"
