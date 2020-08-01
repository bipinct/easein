class User {
  final String createdAt;
  final String name;
  final String address;
  final String phone1;
  final String email1;

  User({this.createdAt, this.name, this.address, this.phone1, this.email1});

  User copyWith(
      {String createdAt,
      String name,
      String address,
      String phone1,
      String email1}) {
    return User(
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      address: address ?? this.address,
      email1: email1 ?? this.email1,
      phone1: phone1 ?? this.phone1,
    );
  }

  dynamic toJson() {
    return {
      'createdAt': createdAt,
      'name': name,
      'address': address,
      'emai1': email1,
      'address': address,
      'phone1': phone1
    };
  }
}
