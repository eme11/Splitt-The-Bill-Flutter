
class RegularExpressions {
  static bool isEmail(String value){
    return !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?").hasMatch(value);
  }

  static bool isRealNumber(String value){
    return !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value);
  }

  static bool isInteger(String value){
    return !RegExp(r'^(?:[1-9]\d*|0)?$').hasMatch(value);
  }
}