#! /bin/bash

# Vars
GIT_PATH="${HOME}/your/folder"

# Function clone_or_pull
clone_or_pull() {
 PROJECT_NAME=$(echo $1 | awk -F '/' '{ print $NF}' | sed 's/.git$//')
 echo -e "\n### REPOS : ${REPOS} - Projet : ${PROJECT_NAME} ###"
 if [ -d ${GIT_PATH}/${REPOS}/${PROJECT_NAME} ]
 then
   echo "Projet ${PROJECT_NAME} déjà présent"
   cd ${GIT_PATH}/${REPOS}/${PROJECT_NAME} && git pull --recurse-submodules
 else
   echo "Création de ${GIT_PATH}/${REPOS}/${PROJECT_NAME}"
   mkdir -p ${GIT_PATH}/${REPOS} && cd ${GIT_PATH}/${REPOS} && git clone $1 --recursive
fi
}


REPOS="YOUR_GITHUB_USERNAME"

clone_or_pull git@github.com:YOUR_GITHUB_USERNAME/YOUR_REPOS.git