/// This class is used to concetrate all the regex of the app that are generalists.
class MyAppRegex {
  static RegExp safeInputRegex = RegExp(r"^[a-zA-Z0-9\s\-_.,!?()áéíóúâêîôûãõçÁÉÍÓÚÂÊÎÔÛÃÕÇ]*$");
}
