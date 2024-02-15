class CartItem {
  String id; 
  final String productName;
  final double price;
  int quantity;
  double total;

  CartItem({
    required this.id, 
    required this.productName,
    required this.price,
    required this.quantity,
    required this.total,
  });
}
