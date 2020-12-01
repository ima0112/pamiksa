String foods = r"""
query Foods ($businessFk: ID){
  foods(businessFk: $businessFk){
    foods{
      id
      name
      description
      price
      photo
      photoUrl
      isAvailable
      isFavorite
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
      description
      price
      photo
      photoUrl
      isAvailable
      isFavorite
      availability
    }
  }
}""";
