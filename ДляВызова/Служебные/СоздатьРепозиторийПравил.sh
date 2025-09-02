#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

BASE_DIR="$(pwd)"

read -e -p "Укажите название репозитория (например UT11/R2Posuda): " RepoName
RepoPath="${BASE_DIR}/${RepoName}"

echo
read -e -p "Введите URL удалённого репозитория (или оставьте пустым для создания нового): " RemoteURL

if [[ -z "$RemoteURL" ]]; then
    echo
    echo "Создаём новый локальный репозиторий по пути: ${RepoPath}"
    mkdir -p "$RepoPath"
    cd "$RepoPath"
    git init

    echo "Клонируем внутренний шаблон KD3Git..."
    git clone "${BASE_DIR}/KD3Git" KD3Git

    echo "Копируем шаблонные файлы..."
    cp "KD3Git/Шаблоны/template_.gitignore" .gitignore
    cp "KD3Git/Шаблоны/template_RepoConfig.sh" RepoConfig.sh
    mkdir -p "KD3Git/Настройки"
    cp "${BASE_DIR}/KD3Git/Настройки/config.local.sh" "KD3Git/Настройки/"

    echo
    echo "Новый репозиторий «${RepoName}» создан и подготовлен."

else
    echo
    echo "Клонируем удалённый репозиторий:"
    echo "  ${RemoteURL}"
    echo "В локальную папку:"
    echo "  ${RepoPath}"
    git clone "${RemoteURL}" "${RepoPath}"
	
	echo "Клонируем внутренний шаблон KD3Git..."
    git clone "${BASE_DIR}/KD3Git" KD3Git

    echo "Копируем шаблонные файлы..."
    cp "KD3Git/Шаблоны/template_.gitignore" .gitignore
    cp "KD3Git/Шаблоны/template_RepoConfig.sh" RepoConfig.sh
    mkdir -p "KD3Git/Настройки"
    cp "${BASE_DIR}/KD3Git/Настройки/config.local.sh" "KD3Git/Настройки/"
	
    echo
    echo "Репозиторий клонирован успешно."
fi

echo
read -p "Нажмите Enter для выхода..."
