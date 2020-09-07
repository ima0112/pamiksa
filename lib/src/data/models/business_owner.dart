class BusinessOwnersModel {
  String id;
  String ci;

  BusinessOwnersModel({this.id, this.ci});

  @override
  String toString() {
    return 'Id: ${this.id}, Ci: ${this.ci}';
  }
}
