class CartItem {
  String id; // Use String for clarity
  final String productName;
  final double price;
  int quantity;
  double total;

  CartItem({
    required this.id, // Assign a unique ID here if needed
    required this.productName,
    required this.price,
    required this.quantity,
    required this.total,
  });
}
