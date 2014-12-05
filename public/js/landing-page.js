;(function(){
	$(document).ready(function() {
		view = new LoginController.View()
		controller = new LoginController(view);
		controller.setEventListeners();
	});

	function LoginController(view) {
		this.view = view
	};

	LoginController.prototype.setEventListeners = function() {
		this.listenToLogin();
	};

	LoginController.prototype.listenToLogin = function() {
		$('#login').click(this.view.showLogin.bind(this));
	};

	LoginController.prototype.listenToSignUp = function() {
		$('#signup').click(this.view.showSignUp.bind(this));
	};

	LoginController.View = function() {
		this.sessionFormContainer = $('#session-form-wrapper');
		this.signUpWrapper = $('#sign-up-wrapper');
		this.loginBox = "<div class='session-form-container'>\n<form action='/sessions/new' method='post'>\n<div class='form-field'>\n<input type='email' name='email' id='user-email' placeholder='email'>\n</div>\n<div class='form-field'>\n<input type='password' name='password' placeholder='password'>\n</div>\n<div><button type='submit'>sign in</button></div>\n</form>\n</div>"
	};

	LoginController.View.prototype.showLogin = function(e) {
		e.preventDefault();
		this.view.sessionFormContainer.html(this.view.loginBox).hide().fadeIn('slow');
	};
})();
	