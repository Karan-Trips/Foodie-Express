// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/model/cart_item.dart';
import 'package:my_app/model/counter_class.dart';
import 'package:my_app/screen/cart_page.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class DetailPage extends StatefulWidget {
  final String itemName;
  final Map<String, double> itemPrices;

  const DetailPage({Key? key, required this.itemName, required this.itemPrices})
      : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference cartCollection =
      FirebaseFirestore.instance.collection('users');
  int _quantity = 0;

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 0) {
      setState(() {
        _quantity--;
      });
    }
  }

  void addToCart() async {
    try {
      final User? user = _auth.currentUser;
      final String uid = user!.uid;

      double price = widget.itemPrices[widget.itemName] ?? 0.0;
      double total = price * _quantity;

      // Create a CartItem object
      CartItem cartItem = CartItem(
        id: const Uuid().v4(), // Generate a unique ID
        productName: widget.itemName,
        price: price,
        quantity: _quantity,
        total: total,
      );

      // Check for an existing item in the cart
      final QuerySnapshot existingCartItemSnapshot = await cartCollection
          .doc(uid)
          .collection('cart')
          .where('productName', isEqualTo: widget.itemName)
          .limit(1)
          .get();

      if (existingCartItemSnapshot.docs.isNotEmpty) {
        // Update the existing document in the cart
        DocumentReference docRef = existingCartItemSnapshot.docs[0].reference;
        await docRef.update({
          'quantity': FieldValue.increment(_quantity),
          'total': FieldValue.increment(total),
          'timestamp': FieldValue.serverTimestamp(),
        });
      } else {
        // Add a new document to the cart
        await cartCollection.doc(uid).collection('cart').add({
          'id': cartItem.id,
          'productName': cartItem.productName,
          'price': cartItem.price,
          'quantity': cartItem.quantity,
          'total': total,
          'timestamp': FieldValue.serverTimestamp(),
        });
      }

      // Provide user feedback (e.g., using a snackbar)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Item added to cart')),
      );
      final cartCounter = Provider.of<CartCounter>(context, listen: false);
      cartCounter.increment();

      setState(() {
        _quantity = 0; // Reset quantity
      });
    } catch (error) {
      // Handle errors and display user-friendly messages
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding item: $error')),
      );
    }
  }

  late final FirebaseAuth auth = FirebaseAuth.instance;
  late final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final CollectionReference cart = _firestore.collection('users');

  List<CartItem> cartItems = [];

  Future<void> fetchCartItems() async {
    final User? user = auth.currentUser;
    if (user != null) {
      final String uid = user.uid;
      try {
        final QuerySnapshot cartSnapshot = await cart
            .doc(uid)
            .collection('cart')
            .orderBy('timestamp', descending: true)
            .get();
        cartItems = cartSnapshot.docs.map((doc) {
          return CartItem(
            id: doc.id,
            total: doc['price'] * doc['quantity'],
            productName: doc['productName'],
            price: doc['price'],
            quantity: doc['quantity'],
          );
        }).toList();
        setState(() {}); // Update UI after fetching data
      } on FirebaseException catch (e) {
        // Handle errors (e.g., show an error message)
        print(e);
      }
    } else {
      // Handle the case where the user is not signed in
      print('User is not signed in');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCartItems(); // Fetch cart items on initialization
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
        centerTitle: true,
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              AnimatedContainer(
                duration: const Duration(seconds: 10),
                curve: Curves.elasticInOut,
                child: IconButton(
                  icon: const Icon(Icons.shopping_cart_checkout),
                  onPressed: () {
                    setState(() {});
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CartScreen()));
                  },
                ),
              ),
              Positioned(
                top: 0,
                right: 8,
                child: Consumer<CartCounter>(
                  builder: (context, counter, child) => CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 10,
                    child: Center(
                      child: Text(
                        counter.count.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/${widget.itemName}.jpg"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.itemName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
              'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  " ₹${widget.itemPrices[widget.itemName]}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Rating:   4.5 (515 Ratings)',
                  style: TextStyle(fontSize: 16, color: Colors.redAccent),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  splashColor: Colors.red,
                  icon: const Icon(Icons.remove),
                  onPressed: _decrementQuantity,
                ),
                Text('$_quantity'),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _incrementQuantity,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'Total: ₹${(widget.itemPrices[widget.itemName] ?? 0.0) * _quantity}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  addToCart();
                },
                child: const Text('Add to Cart'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
