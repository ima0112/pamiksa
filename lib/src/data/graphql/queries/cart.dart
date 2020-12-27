String cart = r"""
query{
  cart {
    id
    name
    description
    price
    photo
    photoUrl
    foodFk
    quantity
    availability
    __typename
    cartAddOns {
      id
      name
      price
      quantity
      __typename
    }
  }
}""";
