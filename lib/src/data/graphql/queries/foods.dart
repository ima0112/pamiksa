String foods = r"""
query Foods ($businessFk: ID){
  foods(businessFk: $businessFk){
    foods{
      id
      name
      price
      photo
      photoUrl
      isAvailable
      availability
    }
  }
}""";
