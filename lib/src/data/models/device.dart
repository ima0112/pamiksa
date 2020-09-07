class DeviceModel {
  String platform;
  String systemVersion;
  String deviceId;
  String model;

  DeviceModel({this.platform, this.deviceId, this.model, this.systemVersion});

  @override
  String toString() {
    return 'Plattform: ${this.platform}, SystemVersion: ${this.systemVersion}, DeviceId: ${this.deviceId}, Model: ${this.model}';
  }
}
