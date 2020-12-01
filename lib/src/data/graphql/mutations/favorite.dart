String createFavorite = r"""
mutation createFavorite($foodFk: ID!) {
createFavorite(foodFk: $foodFk)
}
""";

String deleteFavorite = r"""
mutation deleteFavorite($foodFk: ID!) {
deleteFavorite(foodFk: $foodFk)
}
""";
