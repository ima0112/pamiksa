String devicesByUser = r"""
query devicesByUser($deviceId: ID!) {
  devicesByUser(deviceId: $deviceId) {
    id
    plattform
    systemVersion
    deviceId
    model
    __typename
  }
} """;