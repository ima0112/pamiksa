class BusinessOwner {
  String id;
  String ci;

  BusinessOwner({this.id, this.ci});

  factory BusinessOwner.fromJson(Map<String, dynamic> json) {
    return BusinessOwner(
      id: json['id'],
      ci: json['ci'],
    );
  }

  @override
  String toString() {
    return 'ID: ${this.id}, CI: ${this.ci}';
  }
}
