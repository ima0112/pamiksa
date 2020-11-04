String addons = r"""
query AddOns($foodFk: ID){
  addOns(foodFk: $foodFk){
    id
    name
    price
  }
}
""";
