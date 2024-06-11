import 'dart:math';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:scale_realtime/util/custom_const.dart';

MqttServerClient client = MqttServerClient(mqttBrokerUrl, '');
var pongCount = 0;

class ServiceMQTT {
  static Future<bool> connect() async {
    client.disconnectOnNoResponsePeriod = 1;

    client.autoReconnect = true;
    // client.connectTimeoutPeriod = 2000;
    client.keepAlivePeriod = 5;

    client.onAutoReconnect = onAutoReconnect;
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;

    String randomString = generateRandomString(10);
    String clientIdentifier = 'FlutterClient-$randomString';

    final connMessage = MqttConnectMessage()
        .withClientIdentifier(clientIdentifier)
        // .authenticateAs(usernameBroker, passwordBroker)
        .withWillTopic('willtopic')
        .withWillMessage('willmessage')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMessage;

    try {
      await client.connect();
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
    }

    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      return true;
    } else {
      print(
          'ERROR client connection failed - disconnecting, status is ${client.connectionStatus}');
      client.disconnect();
      return false;
    }
  }

  static void onDisconnected() {
    print('OnDisconnected client callback - Client disconnection');
    if (client.connectionStatus!.disconnectionOrigin ==
        MqttDisconnectionOrigin.solicited) {
      print('OnDisconnected callback is solicited, this is correct');
    } else {
      print(
          'OnDisconnected callback is unsolicited or none, this is incorrect - exiting');
    }
  }

  static void onAutoReconnect() {
    print('Reconnect ...');
  }

  static void onConnected() {
    print('Client Connected');
  }

  static String generateRandomString(int length) {
    const String chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    Random rnd = Random();

    return String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }
}
