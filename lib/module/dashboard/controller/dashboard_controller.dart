import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:scale_realtime/core.dart';
import 'package:scale_realtime/models/mqtt/jumlah/jumlah.dart';
import 'package:scale_realtime/services/service_mqtt.dart';
import 'package:scale_realtime/util/custom_alert.dart';
import 'package:scale_realtime/util/data_shared_helper.dart';
import 'package:scale_realtime/util/data_table_helper.dart';
import 'package:scale_realtime/util/db_helper.dart';
import '../view/dashboard_view.dart';

class DashboardController extends State<DashboardView> {
  static late DashboardController instance;
  late DashboardView view;
  String realtimeTopic = 'widy/timbangan';
  String totalTopic = 'widy/timbangan_jumlah';

  String dataRealtime = "0";
  String dataJumlah = "0";

  List listData = [
    [Icons.scale_outlined, "Timbangan Realtime", "Gram"],
    [Icons.scale_rounded, "Timbangan Total", "Gram"],
  ];

  bool isOn = false;

  bool isLoading = false;
  List<DataRow> data = [];

  TimerController timerController = TimerController();
  @override
  void initState() {
    instance = this;
    super.initState();
    connectFirst();
    refreshData();
  }

  void connectFirst() async {
    await ServiceMQTT.connect();
    client.subscribe(realtimeTopic, MqttQos.atMostOnce);
    client.subscribe(totalTopic, MqttQos.atMostOnce);
    getData();
  }

  void getData() async {
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage>>? c) {
      setState(() {
        isOn = true;
      });
      final message = c![0].payload as MqttPublishMessage;
      String currentTopic = c[0].topic;
      String payload =
          MqttPublishPayload.bytesToStringAsString(message.payload.message);
      Map<String, dynamic> jsonData = {"data": payload};

      print(currentTopic);

      if (currentTopic == realtimeTopic) {
        var a = Jumlah.fromJson(jsonData);
        setState(() {
          dataRealtime = a.data.toString();
        });
      } else if (currentTopic == totalTopic) {
        var a = Jumlah.fromJson(jsonData);
        int b = int.parse(dataJumlah) + int.parse(a.data.toString());
        setState(() {
          dataJumlah = b.toString();
          addItem(dataJumlah);
        });
      }

      DateTime currentTime = DateTime.now();
      startTimer(currentTime);
    });
  }

  void refreshData() async {
    setState(() {
      isLoading = true;
    });
    await Api.list().then((value) async {
      try {
        if (!value.isEmpty) {
          List<DataRow> val = await DataTableHelper.formatData(value);
          setState(() {
            data = val;
          });
        } else {
          setState(() {
            data = [];
          });
        }
      } catch (e) {
        setState(() {
          data = [];
        });
        print(e.toString());
      }
    });
    setState(() {
      isLoading = false;
    });
  }

  Future<void> addItem(String value) async {
    await DBHelper.createItem(value);
    refreshData();
  }

  void saveData() {}

  void startTimer(targetTime) {
    timerController.cancelTimer();
    DateTime futureTime = targetTime.add(const Duration(minutes: 1));
    timerController.startTimer(const Duration(seconds: 1), () async {
      DateTime currentTime = DateTime.now();
      print(currentTime);
      if (currentTime.isAfter(futureTime)) {
        setState(() => isOn = false);
        print("Tidak Ada Aktifitas Yang Lain");
        timerController.cancelTimer();
      } else {
        print("Menunggu hingga $futureTime");
      }
    });
  }

  @override
  void dispose() {
    timerController.cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}

class TimerController {
  Timer? _timer;

  void startTimer(Duration duration, VoidCallback onTimerUpdate) {
    _timer = Timer.periodic(duration, (Timer timer) {
      onTimerUpdate();
    });
  }

  void cancelTimer() {
    if (_timer != null) {
      if (_timer!.isActive) {
        _timer!.cancel();
      }
    }
  }
}
