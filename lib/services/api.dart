import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:scale_realtime/core.dart';
import 'package:scale_realtime/models/api_model.dart';

class Api {
  static Future<dynamic> login(String username, String password) async {
    String url = "$baseUrl/login.php";
    BaseOptions options = BaseOptions(
      baseUrl: url,
      connectTimeout: const Duration(milliseconds: connectTimeout),
      receiveTimeout: const Duration(milliseconds: receiveTimeout),
    );

    Dio dio = Dio(options);

    try {
      final response = await dio.post(
        data: {"username": username, "password": password},
        url,
      );
      if (response.statusCode == 200) {
        dynamic listData = response.data;
        var data = ResultModel.fromJson(listData);

        return data.result;
      } else {
        final Map<String, dynamic> listData = {};
        var data = ResultModel.fromJson(listData);
        return data.result;
      }
    } catch (e) {
      print(e.toString());
      final Map<String, dynamic> listData = {};
      var data = ResultModel.fromJson(listData);
      return data.result;
    }
  }

  static Future<dynamic> list() async {
    String url = "$baseUrl/list.php";
    BaseOptions options = BaseOptions(
      baseUrl: url,
      connectTimeout: const Duration(milliseconds: connectTimeout),
      receiveTimeout: const Duration(milliseconds: receiveTimeout),
    );

    Dio dio = Dio(options);

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        dynamic listData = response.data;
        var data = ResultModel.fromJson(listData);
        print(data.result);

        return data.result;
      } else {
        final Map<String, dynamic> listData = {};
        var data = ResultModel.fromJson(listData);
        return data.result;
      }
    } catch (e) {
      print(e.toString());
      final Map<String, dynamic> listData = {};
      var data = ResultModel.fromJson(listData);
      return data.result;
    }
  }

  static Future<dynamic> laporan(
      String tanggalAwal, String tanggalAkhir) async {
  //   String jsonString = '''
  // {
  //   "result": [
  //     {"tanggal": "2024-06-21 00:00:00", "berat": 234, "namaPengawas": "Andi", "namaTimbangan": "Timbangan 1"},
  //     {"tanggal": "2024-06-21 00:00:00", "berat": 54, "namaPengawas": "Andi", "namaTimbangan": "Timbangan 1"},
  //     {"tanggal": "2024-06-21 00:00:00", "berat": 99, "namaPengawas": "Budi", "namaTimbangan": "Timbangan 2"}
  //   ]
  // }
  // ''';

  //   Map<String, dynamic> jsonData = jsonDecode(jsonString);

  //   var data = ResultModel.fromJson(jsonData);

  //   return data.result;

    String url = "$baseUrl/laporan.php";
    BaseOptions options = BaseOptions(
      baseUrl: url,
      connectTimeout: const Duration(milliseconds: connectTimeout),
      receiveTimeout: const Duration(milliseconds: receiveTimeout),
      // responseType: ResponseType.plain,
    );

    Dio dio = Dio(options);

    try {
      final response = await dio.post(
        data: {"tanggalAwal": tanggalAwal, "tanggalAkhir": tanggalAkhir},
        url,
      );
      print(response.data);
      if (response.statusCode == 200) {
        dynamic listData = response.data;
        var data = ResultModel.fromJson(listData);

        return data.result;
      } else {
        final Map<String, dynamic> listData = {};
        var data = ResultModel.fromJson(listData);
        return data.result;
      }
    } catch (e) {
      print(e.toString());
      final Map<String, dynamic> listData = {};
      var data = ResultModel.fromJson(listData);
      return data.result;
    }
  }

  static Future<dynamic> create(int berat, int idUser) async {
    String url = "$baseUrl/create.php";
    BaseOptions options = BaseOptions(
      baseUrl: url,
      connectTimeout: const Duration(milliseconds: connectTimeout),
      receiveTimeout: const Duration(milliseconds: receiveTimeout),
    );

    Dio dio = Dio(options);

    try {
      final response = await dio.post(
        data: {"id_user": idUser, "berat": berat},
        url,
      );
      print(response.data);
      if (response.statusCode == 200) {
        dynamic listData = response.data;
        var data = ResultModel.fromJson(listData);

        return data.result;
      } else {
        final Map<String, dynamic> listData = {};
        var data = ResultModel.fromJson(listData);
        return data.result;
      }
    } catch (e) {
      print(e.toString());
      final Map<String, dynamic> listData = {};
      var data = ResultModel.fromJson(listData);
      return data.result;
    }
  }
}
