String singIn = r"""
mutation SingIn($email: String!, $password: String!){
  signIn(email: $email, password: $password){
    refreshToken
    token
    user{
      id
      fullName
      adress
      birthday
      email
      photo
    }
  }
} """;
