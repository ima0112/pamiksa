final String sendVerificationCode = r"""
mutation SendVerificationCode ($code: String!, $email: String!){
  sendVerificationCode(code: Scode, email: $email)
} """;
