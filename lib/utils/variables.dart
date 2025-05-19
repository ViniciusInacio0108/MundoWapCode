/// This class is used to get env variables
class MyAppEnvVariables {
  static String baseURL() {
    // we could add this to any env
    return 'https://apimw.sistemagiv.com.br'; // const String.fromEnvironment('BASE_URL');
  }
}
