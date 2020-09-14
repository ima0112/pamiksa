String register_data = r""" 
query{
  provinces{
    id
    name
  }
  municipalities{
    id
    name
    provinceFk
  }
  dateNow
}""";
