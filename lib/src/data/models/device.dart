import 'dart:io';

class DeviceModel {
  String id;
  String platform;
  String systemVersion;
  String deviceId;
  String model;

  DeviceModel(
      {this.id, this.platform, this.deviceId, this.model, this.systemVersion});

  set phoneModel(String model) {
    if (Platform.isAndroid) {
      String aux = "";
      List<String> words = model.split(" ").toList();

      for (var i = 0; i < words.length; i++) {
        aux += words[i][0].toUpperCase() + words[i].substring(1) + " ";
      }

      this.model = aux;
    } else if (Platform.isIOS) {
      this.model = model;
    }
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'platform': platform,
      'systemVersion': systemVersion,
      'deviceId': deviceId,
      'model': model
    };
    return map;
  }

  @override
  String toString() {
    return 'Id: ${this.id}, Platform: ${this.platform}, SystemVersion: ${this.systemVersion}, DeviceId: ${this.deviceId}, Model: ${this.model}';
  }
}
