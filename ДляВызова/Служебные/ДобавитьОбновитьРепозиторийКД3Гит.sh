path=$(pwd)
RulesRepoPath=${path%%KD3Git*}
remoteRepo="https://github.com/DanilDTest/KD3Git.git"

read -e -p "Создать/Обновить репозиторий KD3Git в папке ${RulesRepoPath}? (y/n, по умолчанию y): " answer 
answer=${answer:-y}  # Если answer пустой (Enter), установить его в "y"
if [[ $answer == "y" ]]; then

	if ! grep -q "/KD3Git" "$RulesRepoPath/.gitignore"; then	
		echo -e "\n/KD3Git" >> .gitignore
	fi

	if ! [ -d "$RulesRepoPath/KD3Git" ]; then 
		git clone "$remoteRepo" KD3Git 
	else
		cd "$RulesRepoPath/KD3Git"
		git pull origin main
	fi

else
	break
fi 
$SHELL