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

String foodsById = r"""
query foodsById($foodFk: ID){
  foods(foodFk: $foodFk){
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
