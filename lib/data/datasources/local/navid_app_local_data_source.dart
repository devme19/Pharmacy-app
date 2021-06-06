import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:navid_app/core/error/exceptions.dart';
import 'package:navid_app/data/model/status_model.dart';
import 'package:navid_app/data/model/user_model.dart';

abstract class NavidAppLocalDataSource{
  saveToken(String token);
  String getToken();
  bool isLogin();
  UserModel getUserInfo();
  bool saveLocale(bool isUs);
  bool getLocale();
  bool logOut();
  setFontSize(double size);
  double getFontSize();
  saveUserInfo(UserModel userInfo);
  removeUserInfo();
  setMode(bool darkMode);
  bool getMode();
  saveStatus(StatusModel statusModel);
  StatusModel getStatus();
}


class NavidAppLocalDataSourceImpl implements NavidAppLocalDataSource{
  GetStorage box;
  final String USERINFO =  "userInfo";
  final String PAYMENT =  "payment";
  final String FONT_SIZE =  "fontSize";
  final String DARK_MODE =  "darkMode";
  final String STATUS =  "status";
  final String TOKEN =  "token";
  final String IS_US =  "isUS";
  NavidAppLocalDataSourceImpl(){
   box = GetStorage();
  }
  @override
  bool getLocale() {
    try{
      return box.read(IS_US);
    }catch(e){
      throw CacheException();
    }
  }

  @override
  String getToken() {
    try{
      return box.read(TOKEN);
    }catch(e){
      throw CacheException();
    }
  }

  @override
  UserModel getUserInfo() {
    try{
      String userInfo = box.read(USERINFO);
      String payment = box.read(PAYMENT);
      if(userInfo!=null) {
        print(jsonDecode(userInfo));
        UserModel user = UserModel.fromJson(json.decode(userInfo));
        if(payment!= "null")
          user.payment = Payment.fromJson(json.decode(payment));
        return user;
      } else
        return null;
    }catch(e){
      throw CacheException();
    }
  }

  @override
  bool saveLocale(bool isUs) {
    try{
      box.write(IS_US, isUs);
      return true;
    }on Exception catch(e)
    {
      return false;
    }
  }

  @override
  saveToken(String token) {
    try{
      box.write(TOKEN, token);
    }catch(e){
      throw CacheException();
    }
  }

  @override
  saveUserInfo(UserModel userInfo) {
    try{

      box.write(USERINFO, json.encode(userInfo));
      box.write(PAYMENT, json.encode(userInfo.payment));
    }catch(e){
      throw CacheException();
    }
  }

  @override
  bool isLogin() {
    try{
      String token = box.read(TOKEN);
      if(token != null)
        return true;
      else
        return false;
    }catch(e){
      throw CacheException();
    }
  }

  @override
  removeUserInfo() {
    box.remove(USERINFO);
  }

  @override
  bool logOut() {
    try{
      box.remove(TOKEN);
      box.remove(FONT_SIZE);
      box.remove(USERINFO);
      return true;
    }catch(e){
      throw CacheException();
    }
  }
  @override
  setFontSize(double size) {
    try{
      box.write(FONT_SIZE, size);
    }catch(e){
      throw CacheException();
    }
  }

  @override
  double getFontSize() {
    try{
     return box.read(FONT_SIZE);
    }catch(e){
      throw CacheException();
    }
  }

  @override
  bool getMode() {
    try{
      return box.read(DARK_MODE);
    }catch(e){
      throw CacheException();
    }
  }

  @override
  setMode(bool darkMode) {
    try{
      box.write(DARK_MODE, darkMode);
    }catch(e){
      throw CacheException();
    }
  }

  @override
  StatusModel getStatus() {
    try{
      String status = box.read(STATUS);
      if(status!=null) {
        return StatusModel.fromJson(json.decode(status));
      } else
        return null;
    }catch(e){
      throw CacheException();
    }
  }

  @override
  saveStatus(StatusModel statusModel) {
    try{
      box.write(STATUS, json.encode(statusModel));
    }catch(e){
      throw CacheException();
    }
  }

}