// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/material.dart';

class OrderStatus {
  final String title;
  final String subtitle;
  final String imagePath;

  OrderStatus(
      {required this.title, required this.subtitle, required this.imagePath});
}

class OrderTracking extends StatefulWidget {
  const OrderTracking({Key? key}) : super(key: key);

  @override
  _OrderTrackingState createState() => _OrderTrackingState();
}

class _OrderTrackingState extends State<OrderTracking> {
  List<OrderStatus> orderStatusList = [
    OrderStatus(
        title: "Order Placed",
        subtitle: "Your order has been placed",
        imagePath: "images/shopping-bag.png"),
    OrderStatus(
        title: "Preparing",
        subtitle: "Your order is being prepared",
        imagePath: "images/fry.png"),
    OrderStatus(
        title: "On the way",
        subtitle: "Our delivery executive is on the way to deliver your item",
        imagePath: "images/motorbike.png"),
    OrderStatus(
        title: "Delivered", subtitle: "", imagePath: "images/delivered.png"),
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Order Status",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 30, bottom: 15),
            height: screenHeight / 9,
            child: SizedBox(
              height: 30,
              child: Image.asset(
                "images/wired-lineal-567-french-fries-chips.gif",
              ),
            ),
          ),
          Container(
            height: screenHeight / 25,
            width: screenWidth / 2,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(10)),
            child: const Text(
              "Order Accepted",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 18,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Order ID : 25",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Amt : 254.00 ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "EST : 15:00 ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5, left: 20),
            child: AnotherStepper(
              stepperList: orderStatusList
                  .map(
                    (status) => StepperData(
                      title: StepperText(status.title),
                      subtitle: StepperText(status.subtitle),
                      iconWidget: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 5),
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                        ),
                        child: Image.asset(status.imagePath),
                      ),
                    ),
                  )
                  .toList(),
              stepperDirection: Axis.vertical,
              iconWidth: 50,
              iconHeight: 50,
              activeBarColor: Colors.green,
              inActiveBarColor: Colors.grey,
              inverted: false,
              verticalGap: 20,
              activeIndex: 2,
              barThickness: 8,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.white,
              elevation: 10,
              child: ListTile(
                leading: SizedBox(
                  height: 30,
                  child: Image.asset(
                    "images/home.png",
                  ),
                ),
                title: const Text(
                  "Delivery Address",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry.text of the printing and . ",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
