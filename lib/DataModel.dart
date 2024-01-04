
class UserProfileData  {
  late String name;

// constructor
  UserProfileData({
    required this.name,
  });

  factory UserProfileData.fromMap(Map<String, dynamic> map) {
    return UserProfileData(
      name: map['name'] ?? '',
    );
  }
}

class OrderProduct  {
  String productTitle;
  String productImage;
  String productPrice;

  // constructor
  OrderProduct({
    required this.productTitle,
    required this.productImage,
    required this.productPrice,
  });

  // factory method to create an instance from Firestore data
  factory OrderProduct.fromMap(Map<String, dynamic> map) {
    return OrderProduct(
      productTitle: map['product_name'] ?? '',
      productImage: map['product_image'] ?? '',
      productPrice: map['product_price'] ?? '',
    );
  }
}

class CustomerData{
  late String customerName;

  CustomerData({
    required this.customerName,
  });
  factory CustomerData.fromMap(Map<String, dynamic> map){
    return
      CustomerData(customerName: map['customerName'] ?? '');
  }

}