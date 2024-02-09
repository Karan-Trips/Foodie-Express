// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Detail_page/order_tracking.dart';
import 'package:my_app/Detail_page/pizza_detail.dart';
import 'package:my_app/pages/cart_page.dart';
import 'package:my_app/pages/detail_page.dart';
import 'package:my_app/screen/loginpages/update_profile.dart';

class Mainpage extends StatefulWidget {
  final User user;

  const Mainpage({super.key, required this.user});

  @override
  State<Mainpage> createState() => _Mainpage();
}

class _Mainpage extends State<Mainpage> {
  late User user;
  bool isloggedin = false;
  List<String> data = [
    "Pizza",
    "Burger",
    "Snacks",
    "Drinks",
    "Hot",
    "cake",
  ];

  List<String> data2 = [
    'Chicken Burger',
    'Cheese Pizza',
    'Double Burger',
    'Coco Cola'
  ];
  Map<String, double> data2price = {
    'Chicken Burger': 109,
    'Cheese Pizza': 120,
    'Double Burger': 160,
    'Coco Cola': 90,
  };
  Map<String, double> locationData = {
    'Chicken Burger': 3,
    'Cheese Pizza': 5,
    'Double Burger': 1,
    'Coco Cola': 2,
  };

  List<String> new1 = ['Double Burger', 'Coco Cola'];
  Map<String, double> new1price = {
    'Double Burger': 160,
    'Coco Cola': 90,
  };
  List<Color> bgcolors = [
    const Color.fromARGB(255, 244, 167, 160),
    const Color.fromARGB(255, 226, 108, 100),
    const Color.fromARGB(255, 234, 224, 223),
    const Color.fromARGB(255, 160, 237, 109),
    const Color.fromARGB(255, 253, 142, 240),
    const Color.fromARGB(255, 89, 200, 236),
  ];
  List<String> filteredData = [];

  Widget drawer(String name, IconData icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: ListTileTheme(
        style: ListTileStyle.drawer,
        child: ListTile(
          onTap: onTap,
          leading: Icon(
            icon,
            color: Colors.black,
          ),
          title: Text(
            name,
            style: const TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
      ),
    );
  }

  void navigateToProfile() {
    print('Navigating to Profile');
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UserUpdateProfile(user: widget.user)));
  }

  void navigateToCart() {
    print('Navigating to Cart');
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CartScreen(),
        ));
  }

  void navigateToOrder() {
    print('Navigating to Order');
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const OrderTracking()));
  }

  void navigateToAbout() {
    print('Navigating to About');
  }

  Future<void> logout() async {
    // SystemNavigator.pop();
    // await GoogleSignIn().disconnect();
    // FirebaseAuth.instance.signOut();

    Navigator.pushReplacementNamed(context, "/home");
  }

  Widget _catagories() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Catagories",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
          TextButton(
              onPressed: () {
                setState(() {
                  print("see all");
                });
              },
              child: const Text(
                "See all",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }

  Widget _listview() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              print('Tapped on ${data[index]}');
              String tappedItem = data[index];

              switch (tappedItem) {
                case "Pizza":
                  print("Navigating to the Pizza section");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PizzaListPage()),
                  );
                  break;
                case "Burger":
                  print("Navigating to the Burger section");

                  break;
                case "Snacks":
                  print("Navigating to the Snacks section");

                  break;
                case "Drinks":
                  print("Navigating to the Drinks section");

                  break;
                case "Hot":
                  print("Navigating to the Hot section");

                  break;
                case "cake":
                  print("Navigating to the Cake section");

                  break;
                default:
                  print("Unknown data: $tappedItem");
              }
            },
            child: Container(
              width: 100,
              margin: const EdgeInsets.only(left: 15),
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: bgcolors[index],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    "images/${data[index]}.png",
                    width: 80,
                    height: 80,
                  ),
                  Text(
                    data[index],
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<bool> _onWillPop(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit App'),
        content: const Text('Do you want to exit the App?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              logout();
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    ) as Future<bool>;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          drawer: Drawer(
            child: ListView(padding: EdgeInsets.zero, children: [
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("images/background.jpg"),
                  ),
                ),
                accountName: Text(widget.user.displayName ?? 'Welcome, Guest'),
                accountEmail: Text(widget.user.email ?? 'guest@example.com'),
                currentAccountPicture: CircleAvatar(
                  radius: 40,
                  backgroundImage: widget.user.photoURL != null
                      ? NetworkImage(widget.user.photoURL!)
                      : const AssetImage("images/profile.jpg") as ImageProvider,
                ),
              ),
              drawer("profile", Icons.person, navigateToProfile),
              drawer("Cart", Icons.shopping_cart_rounded, navigateToCart),
              drawer("Order", Icons.shopping_basket_sharp, navigateToOrder),
              drawer("About", Icons.account_box_outlined, navigateToAbout),
              const Divider(
                thickness: 2,
                color: Colors.black,
              ),
              drawer("Log-Out", Icons.logout_outlined, logout),
            ]),
          ),
          appBar: AppBar(
            title: const Center(child: Text('Menu')),
            actions: [
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: CircleAvatar(
                  backgroundImage: widget.user.photoURL != null
                      ? NetworkImage(widget.user.photoURL!)
                      : const AssetImage("images/profile.jpg") as ImageProvider,
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    onChanged: (value) {},
                    autocorrect: true,
                    decoration: const InputDecoration(
                        filled: true,
                        hintText: "Search",
                        hintStyle: TextStyle(color: Colors.redAccent),
                        prefixIcon: Icon(
                          Icons.search_sharp,
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                  ),
                ),
                const SizedBox(height: 20),
                _catagories(),
                _listview(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Popular",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
                      ),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              print("Popular (See all)");
                            });
                          },
                          child: const Text(
                            "See all",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                ),

                ///Popular section check kar lena for pizza and other pages
                SizedBox(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: data2.length,
                    itemBuilder: (context, index) {
                      String itemName = data2[index];
                      return InkWell(
                        onTap: () {
                          print("Item tapped: ${data2[index]}");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailPage(
                                    itemName: itemName,
                                    itemPrices: data2price)),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.4,
                          margin: const EdgeInsets.only(
                              left: 15, right: 5, bottom: 5, top: 5),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                child: Image.asset(
                                  "images/${data2[index]}.jpg",
                                  height: 120,
                                  fit: BoxFit.cover,
                                  width:
                                      MediaQuery.of(context).size.width / 1.4,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data2[index],
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text("Fast Food",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black)),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.red,
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              "4.7",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              "(143 Ratings)",
                                              style: TextStyle(
                                                  color: Colors.black45),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Row(children: [
                                            const Icon(
                                              Icons.location_on,
                                              color: Colors.red,
                                              size: 20,
                                            ),
                                            const SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              "${locationData[itemName]} KM",
                                              style: const TextStyle(
                                                  color: Colors.black45,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ]),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: const BoxDecoration(
                                            color: Colors.redAccent,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(12)),
                                          ),
                                          child: Text(
                                            "₹${data2price[itemName]}",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "New",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
                      ),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              print("New (See all)");
                            });
                          },
                          child: const Text(
                            "See all",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: new1.length,
                    itemBuilder: (context, index) {
                      String itemName = new1[index];
                      return InkWell(
                        onTap: () {
                          print("Item tapped: ${new1[index]}");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailPage(
                                    itemName: itemName, itemPrices: new1price)),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.4,
                          margin: const EdgeInsets.only(
                              left: 15, right: 5, bottom: 5, top: 5),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                child: Image.asset(
                                  "images/${new1[index]}.jpg",
                                  height: 120,
                                  fit: BoxFit.cover,
                                  width:
                                      MediaQuery.of(context).size.width / 1.4,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data2[index],
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text("Fast Food",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black)),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.red,
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              "4.7",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              "(143 Ratings)",
                                              style: TextStyle(
                                                  color: Colors.black45),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Row(children: [
                                            const Icon(
                                              Icons.location_on,
                                              color: Colors.red,
                                              size: 20,
                                            ),
                                            const SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              "${locationData[itemName]} KM",
                                              style: const TextStyle(
                                                  color: Colors.black45,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ]),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: const BoxDecoration(
                                            color: Colors.redAccent,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(12)),
                                          ),
                                          child: Text(
                                            "₹${new1price[itemName]}",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
