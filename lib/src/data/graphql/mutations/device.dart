final String sendDeviceInfo = r"""
mutation SendDeviceInfo ($plattform: String!, $systemVersion: String!, $deviceId: String!, $model: String!, $userFk: ID!){
  sendDeviceInfo(
    plattform: $plattform, 
    systemVersion: $systemVersion, 
    deviceId: $deviceId, 
    model: $model, 
    userFk: $userFk)
} 
""";
