;(function(){
	$(document).ready(function() {
		$('#token-link').click(function(e){
			e.preventDefault();
			$(this).remove();
			$('#family-token-form-field').append("<input type='text' name='family[password]' placeholder='paste your secret family token here. make sure no one is looking!'>");
		});
	});
})();