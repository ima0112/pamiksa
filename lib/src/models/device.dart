class Device {
  String platform;
  double systemVersion;
  String deviceId;
  String model;

  Device({this.platform, this.deviceId, this.model, this.systemVersion});

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
        platform: json['platform'],
        systemVersion: json['systemVersion'],
        deviceId: json['deviceId'],
        model: json['model']);
  }
}
