String userExists = r"""
query UserExists ($email: String!){
  userExists(email: $email)
} """;
