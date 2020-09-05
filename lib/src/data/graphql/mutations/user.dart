final String singUp = r"""
mutation SingUp($fullName: String!, $email: String!, $password: String!, $birthday: Date!, $adress: String!, $provinceFk: ID!, $municipalityFk: ID!){
  signUp(
    fullName: $fullName, 
    email: $email, 
    password: $password,
    birthday: $birthday, 
    adress: $adress, 
    provinceFk: $provinceFk, 
    municipalityFk: $municipalityFk){
    refreshToken
    token
    user{
      id
    }
  }
} 
""";

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
