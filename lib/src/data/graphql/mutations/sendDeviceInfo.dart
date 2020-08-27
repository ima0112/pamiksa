final String sendDeviceInfo = r"""
mutation SendDeviceInfo ($platform: String!, $systemVersion: String!, $deviceId: String!, $model: String!, $userFk: ID!){
  sendDeviceInfo(
    plattform: $platform, 
    systemVersion: $systemVersion, 
    deviceId: $deviceId, 
    model: $model, 
    userFk: $userFk)
} 
""";
