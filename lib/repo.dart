import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'model/model.dart';

abstract class StoreRepository {
  Future<List<StoreModel>> getStore();
}

class SampleStoreRepository implements StoreRepository {
  final baseUrl = "https://fakestoreapi.com/products";
  @override
  Future<List<StoreModel>> getStore() async {
    final response = await http.get(Uri.parse(baseUrl));

    switch (response.statusCode) {
      case HttpStatus.ok:
        final jsonBody = jsonDecode(response.body) as List;
        return jsonBody.map((e) => StoreModel.fromJson(e)).toList();
      default:
        throw NetworkError(response.statusCode.toString(), response.body);
    }
  }
}

class NetworkError implements Exception {
  final String statusCode;
  final String message;

  NetworkError(this.statusCode, this.message);
}
