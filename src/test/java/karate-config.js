function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiUrl: 'https://conduit.productionready.io/api/'
  }
  if (env == 'dev') {
    config.userEmail = 'karatejun@test.com'
    config.userPassword = 'karateapi@2021'
  }
  
  if (env == 'qa') {
    config.userEmail = 'karatejunqa@test.com'
    config.userPassword = 'karateqa@2021'    
  }

  var accessToken = karate.callSingle('classpath:helpers/CreateToken.feature', config).authToken
  karate.configure('headers', {Authorization: 'Token ' + accessToken})

  return config;
}