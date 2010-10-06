#! /bin/bash
# A simple bash script wrapping up the common tasks to 
# setup & deploy an App on Heroku

function output {
  echo "-----> " $1
}

function install_gitmodules {
  git submodule update --init
}

function remove_gitmodules {
  rm -rf `find . -mindepth 2 -name .git`
  git rm --cache `git submodule | cut -f2 -d' '`
  git rm .gitmodules
  git add .
  git config -l | grep '^submodule' | cut -d'=' -f1 | xargs -n1 git config --unset-all
  git commit -m "Heroku setup: Brought submodules into the main repo"
}

function deploy {
  output "What name would you like for your Heroku app ?"
  read -e APP_NAME

  output "Creating ${APP_NAME}"
  heroku create $APP_NAME --stack bamboo-ree-1.8.7 

  output "Adding memcache:5mb addon"
  heroku addons:add memcache:5mb
  
  output "Pushing git repo to ${APP_NAME}"
  git push heroku master

  output "Pushing database to ${APP_NAME}"  
  heroku db:push --app $APP_NAME
  
  output "Restarting ${APP_NAME}"  
  heroku restart $APP_NAME
  
  output "Opening ${APP_NAME}"  
  heroku open $APP_NAME
}


if [ -f "./.gitmodules" ]; then
  ROOT=${PWD}
    
  output "Importing submodules into the main repo"
  
  # Install all the gitmodules
  install_gitmodules
  
  # Install any gitmodules within the plugins
  for file in $( find . -mindepth 2 -name .gitmodules ); do
    cd $(cd "${file%/*}" && pwd) 
    install_gitmodules
    rm -rf .git*
  done
  
  # Heroku doesn't allow gitmodules so import and remove all gitmodules
  output "Removing gitmodules for Heroku"
  
  cd $ROOT
  remove_gitmodules
  
  output "Create & Deploy Heroku App"
  deploy
else 
	output "No .gitmodules found."
	output "Make sure you run this script from the Radiant root"
	output "and that the .gitmodules exist"
fi