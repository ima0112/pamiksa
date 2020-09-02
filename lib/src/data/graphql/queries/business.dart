String business = r"""query FetchBusiness {
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