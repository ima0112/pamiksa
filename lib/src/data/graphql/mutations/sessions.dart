String signOutAll = r"""
mutation signOutAll($deviceId: ID!) {
signOutAll(deviceId: $deviceId)
}
""";