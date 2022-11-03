import 'package:shared_preferences/shared_preferences.dart';

class MyPreference {

  static Future<SharedPreferences> _mPref = SharedPreferences.getInstance();

  static var email = "email";
  static var password = "password";
  static var userId = "userId";
  static var Fname = "Fname";
  static var Lname = "Lname";
  static var productId = "productId";
  static var timeZone = "timeZone";

  static addStringToSF(var mKey,String mValue) async {
    SharedPreferences mPref = await _mPref;
    mPref.setString(mKey, mValue);
  }

  static addIntToSF(var mKey,int mValue) async {
    SharedPreferences mPref = await _mPref;
    mPref.setInt(mKey, mValue);
  }

  static addDoubleToSF(var mKey,double mValue) async {
    SharedPreferences mPref = await _mPref;
    mPref.setDouble(mKey, mValue);
  }

  static addBoolToSF(var mKey,bool mValue) async {
    SharedPreferences mPref = await _mPref;
    mPref.setBool(mKey, mValue);
  }

  static getStringToSF(String mKey) async {
    SharedPreferences mPref = await _mPref;
    return mPref.getString(mKey);
  }

  static removeToSF(var mKey) async{
    SharedPreferences mPref = await _mPref;
    mPref.remove(mKey);
  }
}