class DeviceModel {
  String plattform;
  String systemVersion;
  String deviceId;
  String model;

  DeviceModel({this.plattform, this.deviceId, this.model, this.systemVersion});

  set phoneModel(String model) {
    String aux = "";
    List<String> words = model.split(" ").toList();

    for (var i = 0; i < words.length; i++) {
      aux += words[i][0].toUpperCase() + words[i].substring(1) + " ";
    }

    this.model = aux;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'plattform': plattform,
      'systemVersion': systemVersion,
      'deviceId': deviceId,
      'model': model
    };
    return map;
  }

  @override
  String toString() {
    return 'Plattform: ${this.plattform}, SystemVersion: ${this.systemVersion}, DeviceId: ${this.deviceId}, Model: ${this.model}';
  }
}
