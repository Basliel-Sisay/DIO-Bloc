import 'package:dio/dio.dart';

class Service{
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      headers:{
        'Content-Type': 'application/json'
      },
    ),
  );
}