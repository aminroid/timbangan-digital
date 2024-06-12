import 'package:dio/dio.dart';
import 'package:scale_realtime/core.dart';
import 'package:scale_realtime/models/api_model.dart';
import 'package:scale_realtime/util/data_shared_helper.dart';

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

  static Future<dynamic> create(int berat) async {
    int? idUser = await DataSharedPreferences().readInt("idUser");

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
