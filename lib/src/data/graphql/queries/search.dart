String sarch = r"""
query Search ($name: String!){
  searchFood(name: $name){
    id
    name
    description
    price
    photo
    photoUrl
    isAvailable
    availability
  }
}""";
