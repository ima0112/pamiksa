String userExists = r"""
query UserExists ($email: String!){
  userExists(email: $email)
} """;

String userLocation = r"""
query UserLocation{
  provinces{
    id
    name
    municipality{
      id
      name
      provinceFk
    }
  }
} """;

String checkSession = r"""
query CheckSession($deviceId: String!, $appVersion: String!, $systemVersion: String!, $refreshToken: String!){
  checkSession(deviceId: $deviceId, appVersion: $appVersion, systemVersion: $systemVersion, refreshToken: $refreshToken)
}""";

String me = r"""
query{
  me{
    id
    fullName
    adress
    photo
    photoUrl
    email
  }
}""";
