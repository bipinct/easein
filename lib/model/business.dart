class Business {
  final String createdAt;
  final String shopName;
  final String address;
  final String publicid;

  Business({
    this.createdAt,
    this.shopName,
    this.address,
    this.publicid,
  });

  Business copyWith(
      {String createdAt, String shopName, String address, String publicid}) {
    return Business(
        createdAt: createdAt ?? this.createdAt,
        shopName: shopName ?? this.shopName,
        address: address ?? this.address,
        publicid: publicid ?? this.publicid);
  }

  dynamic toJson() {
    return {
      'createdAt': createdAt,
      'shopName': shopName,
      'address': address,
      'publicid': publicid
    };
  }
}
