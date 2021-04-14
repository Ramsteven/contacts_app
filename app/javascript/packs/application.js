// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
import 'bootstrap'
import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import 'jquery'

Rails.start()
Turbolinks.start()
ActiveStorage.start()

$(document).ready(function() {
    $('#attached_attached_csv').change(function(e) {
        if (e.target.files != undefined) {
            var reader = new FileReader();
            
            reader.onload = function(e) {
													              
						console.log(e.target.result.split("\n")[0]);
							//$('#text').html(e.target.result.split("\n")[0]);
            var content = e.target.result.split("\n")[0].split(',');
						var contentReal = ["fullname", "address", "email", "credit_card", "phone", "birth_date"]
						console.log(contentReal)
     				var aux= ""
						var final= "<h1>Assignament headers</h1><p>Please assing each header for save in the database</p>"
	
						for (var i=0; i < content.length; i++ ){
								aux+= "<option value='"+content[i]+"'>	"+content[i]+"</option>"
						}
						for (var y=0; y < contentReal.length; y++){
							final+= "<label for='"+contentReal[y]+"'>"+contentReal[y]+": </label> \
								<select type='text' name='headers["+contentReal[y]+"]' list='header'> "+aux+"</select>"
						}
							var form= "<form name='headers'>"+final+" </form>"
											$("#text").html(form);
            };
            reader.readAsText(e.target.files.item(0));
        }
        return false;
    });
 });
