class TimbangModel {
  dynamic id;
  dynamic tanggal;
  dynamic berat;
  TimbangModel({this.id, this.tanggal, this.berat});

  factory TimbangModel.fromJson(dynamic object) {
    return TimbangModel(
        id: object['id'], tanggal: object['tanggal'], berat: object['berat']);
  }
}

class ResultModel {
  dynamic result;
  ResultModel({this.result});

  factory ResultModel.fromJson(dynamic object) {
    return ResultModel(result: object['result']);
  }
}
