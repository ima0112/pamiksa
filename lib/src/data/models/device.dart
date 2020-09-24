class DeviceModel {
  String id;
  String plattform;
  String systemVersion;
  String deviceId;
  String model;

  DeviceModel(
      {this.id, this.plattform, this.deviceId, this.model, this.systemVersion});

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
    return 'Plattform: ${this.plattform}, SystemVersion: ${this.systemVersion}, DeviceId: ${this.deviceId}, Model: ${this.model}';
  }
}
