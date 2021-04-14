$(document).ready(function() {
  alert("hola")
    $('#attached_attached_csv').change(function(e) {
        if (e.target.files != undefined) {
            var reader = new FileReader();
            
            reader.onload = function(e) {
													              
							//$('#text').html(e.target.result.split("\n")[0]);
                //content = e.target.result.split("\n")[0];
								console.log(e.target.result.split("\n")[0]);

           		$('#text').html("<%= j render partial: 'layouts/form') %>".html_safe);
            };
            reader.readAsText(e.target.files.item(0));
        }
        return false;
    });
});

