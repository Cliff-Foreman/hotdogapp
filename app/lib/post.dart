import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:dio/dio.dart';

void upload() async {
  Response response;
  Dio dio = new Dio();

  FormData formData = new FormData.fromMap({
    "file": await MultipartFile.fromFile("assets/test.png"),
  });
  response = await dio.post("http://0.0.0.0:5000/upload", data: formData);

  print(response.data.toString());
}

void getter() async {
  Response response;
  Dio dio = new Dio();

  response = await dio.get("http://0.0.0.0:5000/");

  print(response.data.toString());
}

void main() {
  upload();
}