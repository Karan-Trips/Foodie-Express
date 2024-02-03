import 'package:flutter/material.dart';

enum OrderStatus { processing, outForOrder, delivered }

class OrderStatusPage extends StatefulWidget {
  const OrderStatusPage({Key? key}) : super(key: key);

  @override
  State<OrderStatusPage> createState() => _OrderStatusPageState();
}

class _OrderStatusPageState extends State<OrderStatusPage> {
  OrderStatus orderStatus =
      OrderStatus.processing; //change according to firebase or random
  bool isRefreshing = false;

  Future<void> updateStatus() async {
    setState(() {
      isRefreshing = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      orderStatus = OrderStatus.delivered;
      isRefreshing = false;
    });
  }

  String getOrderStatusText() {
    switch (orderStatus) {
      case OrderStatus.processing:
        return "Processing";
      case OrderStatus.outForOrder:
        return "Out for Order";
      case OrderStatus.delivered:
        return "Delivered";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Status"),
      ),
      body: RefreshIndicator(
        onRefresh: updateStatus,
        child: Column(
          children: [
            const SizedBox(
              height: 350,
            ),
            SizedBox(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Order Status:",
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      getOrderStatusText(),
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    isRefreshing
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: updateStatus,
                            child: const Text("Refresh"),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
