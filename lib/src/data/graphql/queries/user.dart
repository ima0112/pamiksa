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
query CheckSession($deviceId: String!){
  checkSession(deviceId: $deviceId)
}""";

String favorite = r"""
query{
  favorites{
    id
    name
    price
    photo
    isAvailable
    availability
    business{
      id
      name
    }
    addOns{
      id
      name
      price
    }
    category{
      id
      name
    }
    createdAt
  }
}""";

String me = r"""
query{
  me{
    id
    fullName
    adress
    photo
    email
  }
}
""";
