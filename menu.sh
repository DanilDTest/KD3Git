#!/bin/bash

# Цвета для оформления
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Пути и настройки
PARENT_REPO_DIR="$(dirname "$(pwd)")"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Функция для получения информации о репозитории
get_repo_info() {
    # Переходим в родительский репозиторий
    cd "$PARENT_REPO_DIR" || return
    
    # Получаем имя репозитория (последняя часть пути)
    repo_name=$(basename $(git rev-parse --show-toplevel) 2>/dev/null) 2>/dev/null
    
    # Получаем текущую ветку
    branch=$(git branch --show-current 2>/dev/null)
    
    # Возвращаемся обратно
    cd "$SCRIPT_DIR" || return
    
    if [ -z "$repo_name" ]; then
        echo -e "${RED}Не git репозиторий${NC}"
    else
        echo -e "${CYAN}Репозиторий: ${YELLOW}$repo_name${NC} | ${CYAN}Ветка: ${YELLOW}${branch:-unknown}${NC}"
    fi
}

# Функция для выполнения скриптов
run_script() {
    local script="$SCRIPT_DIR/$1"
    echo -e "${YELLOW}Запуск скрипта: $(basename "$script")${NC}"
    echo -e "${YELLOW}Для прерывания скрипта нажмите Ctrl+C${NC}"
    
    if [ -f "$script" ]; then
        (trap 'echo -e "\n${RED}Скрипт прерван пользователем${NC}"; exit 1' INT; bash "$script")
        local status=$?
        
        [ $status -eq 0 ] && echo -e "${GREEN}Скрипт выполнен успешно${NC}" \
                          || echo -e "${RED}Завершение с кодом $status${NC}"
    else
        echo -e "${RED}Файл скрипта не найден: $script${NC}"
    fi
    
    # Обновляем информацию о репозитории после выполнения скрипта
    repo_info=$(get_repo_info)
    
    read -p "$(echo -e "\n${YELLOW}Нажмите Enter чтобы вернуться в меню...${NC}")"
}

# Функция для отображения меню
show_menu() {
    clear
    # Получаем актуальную информацию о репозитории
    repo_info=$(get_repo_info)
    
    #echo -e "${YELLOW}=== Меню управления KD3GIT ===${NC}"
    echo -e "$repo_info"
    echo -e "${YELLOW}================================${NC}"
    echo -e "${GREEN}Основные скрипты:${NC}"
    echo -e "${GREEN}1. ${BLUE}Обновить правила разобрав обработку${NC}"
    echo -e "${GREEN}2. ${BLUE}Собрать правила по предлагаемой ветви${NC}"
    #echo -e "${GREEN}3. ${BLUE}Создать ветку черри-пиком коммита${NC}"
    echo -e "${GREEN}3. ${BLUE}Обновить правила по рабочей базе${NC}"
  
    echo -e "\n${GREEN}Служебные скрипты:${NC}"
    echo -e "${GREEN}4. ${BLUE}Переименовать слитые ветви${NC}"
    echo -e "${GREEN}5. ${BLUE}Добавить/обновить репозиторий к ДЗ Гит${NC}"

    echo -e "\n${RED}0. Выход${NC}"
    echo -e "${YELLOW}================================${NC}"
    echo -n "Выберите скрипт для запуска: "
}

# Основной цикл
while true; do
    trap 'echo -e "\n${RED}Для выхода используйте пункт 0 меню${NC}"; sleep 1' INT
    
    show_menu
    read -r choice
    
    case $choice in
        1) run_script "ДляВызова/ВызовОбновленияПравилЧерезРазборОбработки.sh" ;;
        2) run_script "ДляВызова/СобратьПравилаПоПредлагаемойВетви.sh" ;;
        #3) run_script "ДляВызова/ВызовСозданияВеткиЧеррипикомКоммита.sh" ;;
        3) run_script "ДляВызова/ОбновитьПравилаПоРабочейБазе.sh" ;;
        4) run_script "ДляВызова/Служебные/ПереименоватьСлитыеВетки.sh" ;;
        5) run_script "ДляВызова/Служебные/ДобавитьОбновитьРепозиторийКД3Гит.sh" ;;
        0) exit 0 ;;
        *) echo -e "${RED}Неверный выбор. Попробуйте снова.${NC}"; sleep 1 ;;
    esac
done