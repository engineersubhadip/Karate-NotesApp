function fn() {
	var env = karate.env || 'dev'; // get system property 'karate.env'
	karate.log('karate.env system property was:', env);
	if (!env) {
		env = 'dev';
	}
	var config = {
		env: env,
	};
	if (env == 'dev') {
		config.baseURL = 'https://practice.expandtesting.com/notes/api/';
		config.loginEndPoint = 'users/login';
		config.logoutEndPoint = 'users/logout';
	} else if (env == 'qa') {
		config.baseURL = 'https://practice.expandtesting.com/notes/api/';
		config.loginEndPoint = 'users/login';
	}
	return config;
}
