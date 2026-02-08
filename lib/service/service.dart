import 'dart:developer';

import 'package:dio/dio.dart';

import '../Models/e_commerce_model.dart';

class NetworkingService {
  final String baseUrl = "https://fakestoreapi.com/products";
  final Dio dio = Dio();

  Future<List<ECommerceModel>?> getProducts() async {
    try {
      final response = await dio.get(baseUrl);

      if (response.statusCode == 200) {
        log("status code = ${response.statusCode}");
        List<dynamic> data = response.data;

        return data.map((item) => ECommerceModel.fromJson(item)).toList();
      } else {
        log("Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      log("Exception: $e");
      return null;
    }
  }
}
