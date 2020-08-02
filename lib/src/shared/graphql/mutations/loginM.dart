final String businessLogin = r"""
      mutation BusinessLogin($email: String!, $password: String!){
        businessLogin(email: $email, password: $password){
          token
          refreshToken
          user{
            fullName,
            userId,
            telephone,
            phone,
            ci,
            email,
            address,
            businessUserProvincia,
            businessUserMunicipio
          }
        }
      }
""";