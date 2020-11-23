class DeviceModel {
  String id;
  String plattform;
  String systemVersion;
  String deviceId;
  String model;

  DeviceModel(
      {this.id, this.plattform, this.deviceId, this.model, this.systemVersion});

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
      'id': id,
      'plattform': plattform,
      'systemVersion': systemVersion,
      'deviceId': deviceId,
      'model': model
    };
    return map;
  }

  @override
  String toString() {
    return 'Id: ${this.id}, Plattform: ${this.plattform}, SystemVersion: ${this.systemVersion}, DeviceId: ${this.deviceId}, Model: ${this.model}';
  }
}
