final String signUp = r"""
mutation SignUp($fullName: String!, $email: String!, $password: String!, $birthday: Date!, $adress: String!, $provinceFk: ID!, $municipalityFk: ID!,  $platform: String!, $systemVersion: String!, $appVersion: String!, $deviceId: String!, $model: String!){
  signUp(
    fullName: $fullName,
    email: $email,
    password: $password,
    birthday: $birthday,
    adress: $adress,
    provinceFk: $provinceFk,
    municipalityFk: $municipalityFk,
    platform: $platform, 
    appVersion: $appVersion,
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
mutation SingIn($email: String!, $password: String!,  $platform: String!, $systemVersion: String!, $appVersion: String!, $deviceId: String!, $model: String!, $app: String!){
  signIn(email: $email, password: $password, platform: $platform, systemVersion: $systemVersion, appVersion: $appVersion, deviceId: $deviceId, model: $model, app: $app){
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
mutation ResetPassword($email: String!, $password: String!, $platform: String!, $systemVersion: String!, $deviceId: String!, $model: String!, $app: String!, $appVersion: String!){
  resetPassword(email: $email, password: $password, platform: $platform, systemVersion: $systemVersion, deviceId: $deviceId, model: $model, app: $app, appVersion: $appVersion){
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
mutation EditProfile ($photo: String, $fullName: String, $adress: String, $email: String){
  editProfile(photo: $photo, adress: $adress, fullName: $fullName, email: $email)
}""";

final String changePassword = r"""
mutation ChangePassword ($password: String!){
  changePassword(password: $password)
}""";

final String refreshToken = r"""
mutation RefreshToken ($refreshTokenValue: String!, $appVersion: String!){
  refreshTheToken(refreshTokenValue: $refreshTokenValue, appVersion: $appVersion){
    token
    refreshToken
  }
}
""";
