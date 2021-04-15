# Twitter clone

this app was create with version of rails 6.1.3

Things you may want to cover:

*Clone repository
* you need also have installed redis , because we will run background proccess
* sudo apt update
* sudo apt install redis-server
* check if your service redis is active with: sudo systemctl status redis
* run yarn install
* run yarn add bootstrap jquery popper.js
* run bundle install in your terminal  nt
* inside the folder of project run:  rails db:migrate
* optional run rails db:seed for create users automaticly with this credentials:
	email = 'test@example.com'
	password = 'password'
* run bundle exec sidekiq in other instance of the termial inside contact_import folder
* finally run: rails server 
* go to browser and type localhost:3000
* logged and attach one file and set the headers correctly
* in attached file you could see the attached files correctly and import to the data base
* contact have the the contacts import correctly and fail contact the files that have any error
