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