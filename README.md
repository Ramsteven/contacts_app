# Contact import CSV

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
* you should run and add this credentials with  EDITOR=nvim rails credentials:edit

development: <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; encrypt:<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; key_encrypt: 99b8f9fdf808e8d919e1873d06b4035c <br/>

  
test: <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; encrypt:<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; key_encrypt: 99b8f9fdf808e8d919e1873d06b4035c <br/>
    
* the key_encrypt above can be changed for hash more secure of any value if you prefer
* optional run rails db:seed for create users automaticly with this credentials:
	email = 'test@example.com'
	password = 'password'
* run bundle exec sidekiq in other instance of the termial inside contact_import folder
* finally run: rails server 
* go to browser and type localhost:3000
* logged and attach one file and set the headers correctly
* in attached file you could see the attached files correctly and import to the data base
* contact have the the contacts import correctly and fail contact the files that have any error
