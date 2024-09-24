import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class networkdata {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {'Content-Type': 'application/json'}));
  }

  // networkdata() {
  //   dio = Dio(BaseOptions(
  //     baseUrl: 'https://newsapi.org',
  //     receiveDataWhenStatusError: true,
  //   ));
  // }

  static Future<Response?> getData(
      {required url,
      Map<String, dynamic>? qury,
      String? token,
      String? lan}) async {
    dio?.options.headers = {
      'Authorization': token,
      'lang': lan,
      'Content-Type': 'application/json'
    };
    return await dio?.get(url, queryParameters: qury);
  }

  static Future<Response?> postData(
      {@required url,
      Map<String, dynamic>? qury,
      @required Map<String, dynamic>? data,
      String? token,
      String lan = 'ar'}) async {
    dio?.options.headers = {
      'Authorization': token,
      'lang': lan,
      'Content-Type': 'application/json'
    };
    return await dio?.post(url, queryParameters: qury, data: data);
  }
}
