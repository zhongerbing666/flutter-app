import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
// BaseOptions options = BaseOptions(
//   receiveTimeout: 3000,
// );
// Dio dio = Dio(options);
BaseOptions baseOptions = new BaseOptions(
  connectTimeout: 5000,
  receiveTimeout: 3000,
);
Dio dio = new Dio(baseOptions)..interceptors.add(new CustomInterceptors());

class CustomInterceptors extends InterceptorsWrapper {
  onRequest(RequestOptions options) async {
    // 在请求被发送之前做一些事情
    return options; //continue
  }

  onResponse(Response response) async {
    // var data = response.data;
    // 在返回响应数据之前做一些预处理
    return response; // continue
  }

  onError(DioError e) async {
    // 当请求失败时做一些预处理
    return e; //continue
  }
}

getVerseCategory(String url, Map params) async {
  Response response = await dio.request("https://v1.jinrishici.com/" + url,
      data: params, options: Options(method: "GET"));
  return response;
  // return json.decode(response.toString());
}
