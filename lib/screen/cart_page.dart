import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_app/model/cart_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference cartCollection =
      FirebaseFirestore.instance.collection('users');

  Future<List<CartItem>> getCartItems() async {
    final User? user = _auth.currentUser;
    final String uid = user!.uid;
    final QuerySnapshot cartSnapshot = await cartCollection
        .doc(uid)
        .collection('cart')
        .orderBy('timestamp', descending: true)
        .get();

    return cartSnapshot.docs.map((doc) {
      return CartItem(
        id: doc.id,
        total: doc['price'] * doc['quantity'],
        productName: doc['productName'],
        price: doc['price'],
        quantity: doc['quantity'],
      );
    }).toList();
  }

  
  void deletedata(String docId) async {
    final User? user = _auth.currentUser;
    final String uid = user!.uid;
    try {
      await cartCollection.doc(uid).collection('cart').doc(docId).delete();
      setState(() {});
      print('Item deleted from Firebase');
    } catch (error) {
      print('Error deleting item: $error');
      // Handle error gracefully, e.g., display a user-friendly message
    }
  }

  void processPayment() {
    // Implement your payment processing logic here
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PaymentScreen()),
    );

    print('Payment processed!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: FutureBuilder(
        future: getCartItems(),
        builder: (context, AsyncSnapshot<List<CartItem>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Your cart is empty.'),
            );
          } else {
            List<CartItem> cartItems = snapshot.data!;

            return ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(cartItems[index].productName),
                  direction: DismissDirection.startToEnd,
                  background: Container(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.centerLeft,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  onDismissed: (direction) async {
                    try {
                      deletedata(cartItems[index]
                          .id); // Assuming you have an 'id' field
                    } catch (error) {
                      // Handle error
                    }
                  },
                  child: Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    elevation: 3,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      title: Text(
                        cartItems[index].productName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            'Total Price: ₹${cartItems[index].total.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Quantity: ${cartItems[index].quantity}',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: processPayment,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue, // Background color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0), // Set the border radius
          ),
          minimumSize: const Size(250, 60), // Set the minimum size
        ),
        child: const Text(
          'Proceed to Payment',
          style: TextStyle(
            color: Colors.black87, // Text color
            fontSize: 18, // Set the font size
          ),
        ),
      ),
    );
  }
}

// _____________________

//---------------- PAYMENT SCREEN
// /--------------/

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _cardHolderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _cardNumberController,
              decoration: const InputDecoration(
                labelText: 'Card Number',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _expiryDateController,
                    decoration: const InputDecoration(
                      labelText: 'Expiry Date',
                    ),
                    keyboardType: TextInputType.datetime,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _cvvController,
                    decoration: const InputDecoration(
                      labelText: 'CVV',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _cardHolderController,
              decoration: const InputDecoration(
                labelText: 'Card Holder',
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Add logic to process payment
                // For simplicity, print the entered details
                print('Card Number: ${_cardNumberController.text}');
                print('Expiry Date: ${_expiryDateController.text}');
                print('CVV: ${_cvvController.text}');
                print('Card Holder: ${_cardHolderController.text}');

                // Navigate to a success page or handle payment processing here
              },
              child: const Text('Make Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
