import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static late SharedPreferences pref;
  static initialCacheObject()async
  {
    pref = await SharedPreferences.getInstance();
  }

  static Future<dynamic> saveData({
    required String key,
    required dynamic value
  })async{
    if(value is String) return await pref.setString(key, value);
    if(value is int)    return await pref.setInt(key, value);
    if(value is bool)   return await pref.setBool(key, value);
                        return await pref.setDouble(key, value);
  }

  static dynamic getData(String key)
  {
    return pref.get(key);
  }

  static Future<bool> removeData({required String key})async
  {
    return await pref.remove(key);
  }
}