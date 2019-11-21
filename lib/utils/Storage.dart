import 'package:shared_preferences/shared_preferences.dart';

class Storage{
    static Future<void> setString(String key,String value) async{
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString(key, value);
    }

    static Future<String> getString(String key) async{
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        return sharedPreferences.getString(key);
    }

    static Future<void> setBool(String key,bool value) async{
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setBool(key, value);
    }

    static Future<void> setInt(String key,int value) async{
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setInt(key, value);
    }

    static Future<void> setDouble(String key,double value) async{
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setDouble(key, value);
    }

    static Future<void> remove(String key) async{
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.remove(key);
    }

    static Future<void> clear() async{
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.clear();
    }
}