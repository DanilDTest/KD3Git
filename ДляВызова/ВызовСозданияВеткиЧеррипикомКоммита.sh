set +o history
source $(git rev-parse --show-toplevel)/Настройки/config.sh

gitBranchName=$1

cd $gitCatPath

read -e -p 'branch: ' -i "${gitBranchName:-dev}" gitBranchName

git cherry-pick --skip
"$PathToRepoEditScripts/СоздатьВеткуЧерепикомКоммита.sh" "$gitBranchName"

$SHELL