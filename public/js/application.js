;(function(){
	$(document).ready(function() {
		$('#token-link').click(function(e){
			e.preventDefault();
			$(this).remove();
			$('#family-token-form-field').append("<label for='family[password]'>Secret Family Token</label>\n<input type='text' name='family[password]'>");
		})
	});
})();
	