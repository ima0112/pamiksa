final String signUp = r"""
mutation SignUp($fullName: String!, $email: String!, $password: String!, $birthday: Date!, $adress: String!, $provinceFk: ID!, $municipalityFk: ID!,  $plattform: String!, $systemVersion: String!, $deviceId: String!, $model: String!){
  signUp(
    fullName: $fullName,
    email: $email,
    password: $password,
    birthday: $birthday,
    adress: $adress,
    provinceFk: $provinceFk,
    municipalityFk: $municipalityFk,
    plattform: $plattform, 
    systemVersion: $systemVersion, 
    deviceId: $deviceId, 
    model: $model){
    refreshToken
    token
    user{
      id
      fullName
      adress
      photo
      email
      birthday
    }
  }
}
""";

String singIn = r"""
mutation SingIn($email: String!, $password: String!,  $plattform: String!, $systemVersion: String!, $deviceId: String!, $model: String!){
  signIn(email: $email, password: $password, plattform: $plattform, systemVersion: $systemVersion, deviceId: $deviceId, model: $model){
    refreshToken
    token
    user{
      id
      fullName
      adress
      photo
      email
      birthday
    }
  }
} """;

String signOut = r"""
mutation signOut($deviceId: ID!){
  signOut(deviceId: $deviceId)
}
""";

String resetPassword = r"""
mutation ResetPassword($email: String!, $password: String!, $plattform: String!, $systemVersion: String!, $deviceId: String!, $model: String!){
  resetPassword(email: $email, password: $password, plattform: $plattform, systemVersion: $systemVersion, deviceId: $deviceId, model: $model){
    refreshToken
    token
    user{
      id
      fullName
      adress
      photo
      email
      birthday
    }
  }
} """;

final String sendVerificationCode = r"""
mutation SendVerificationCode ($code: String!, $email: String!, $question: String!){
  sendVerificationCode(
    code: $code, 
    email: $email,
    question: $question)
} """;

final String editProfile = r"""
mutation($photo: String, $fullName: String, $adress: String){
  editProfile(photo: $photo, adress: $adress, fullName: $fullName)
}
""";