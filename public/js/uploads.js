;(function(){
	$(document).ready(function() {

		$('#new-upload').click(function(e){
			e.preventDefault();
			$('#upload-menu').fadeIn('fast');
		});

		$('#close').click(function(e){
			e.preventDefault();
			$('#upload-menu').fadeOut('fast');
		});
		
	});
})();