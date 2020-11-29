String registerDataQuery = r""" 
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
