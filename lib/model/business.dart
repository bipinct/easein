class Business {
  final String createdAt;
  final String shopName;
  final String address;
  final String publicid;
  final String qrcodeString;
   bool isSelected;

  Business(
      {this.createdAt,
      this.shopName,
      this.address,
      this.publicid,
      this.qrcodeString,
      this.isSelected});

  Business copyWith(
      {String createdAt,
      String shopName,
      String address,
      String publicid,
      bool isSelected}) {
    return Business(
        createdAt: createdAt ?? this.createdAt,
        shopName: shopName ?? this.shopName,
        address: address ?? this.address,
        publicid: publicid ?? this.publicid,
        qrcodeString: qrcodeString ?? this.qrcodeString,
        isSelected: isSelected ?? this.isSelected);
  }

  dynamic toJson() {
    return {
      'createdAt': createdAt,
      'shopName': shopName,
      'address': address,
      'publicid': publicid,
      'qrcodeString': qrcodeString,
      'isSelected': isSelected
    };
  }
}
