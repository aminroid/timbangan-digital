// class MQTTModel {
//   dynamic result;
//   MQTTModel({this.result});

//   factory MQTTModel.fromJson(dynamic object) {
//     return MQTTModel(result: object['result']);
//   }
// }

class MQTTModel {
  dynamic id;
  dynamic berat;
  MQTTModel({this.id, this.berat});

  factory MQTTModel.fromJson(dynamic object) {
    return MQTTModel(id: object['id'], berat: object['berat']);
  }
}
