String business = r"""query{
  business {
    id
    name
    description
    businessOwner {
      id
      ci
    }
    adress
    phone
    email
    photo
  }
}""";