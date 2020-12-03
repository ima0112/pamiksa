String devicesByUser = r"""
query devicesByUser($deviceId: ID!) {
  devicesByUser(deviceId: $deviceId) {
    id
    platform
    systemVersion
    deviceId
    model
    __typename
  }
} """;
