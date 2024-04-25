function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  
  if (env == 'dev') {
    var config = {
      apiUrl: 'https://conduit-api.bondaracademy.com/api/'
    }
    config.userEmail = 'test.user@gmail.com'
    config.userPassword = 'Mtech123'
  }
  if (env == 'qa') {
    var config = {
      apiUrl: 'https://conduit-api.bondaracademy.com/api/'
    }
    config.userEmail = 'karate7568@test.com'
    config.userPassword = 'Mtech123'
  }

  var accessToken = karate.callSingle('classpath:helpers/CreateToken.feature', config).authToken //stores the token into accessToken variable
  karate.configure('headers', {Authorization: 'Token ' + accessToken})   //set the accessToke as a header for entire karate feature file

  return config;
}