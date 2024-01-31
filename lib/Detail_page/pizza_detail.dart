import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PizzaDetailsPage extends StatefulWidget {
  final Pizza pizza;

  const PizzaDetailsPage({Key? key, required this.pizza}) : super(key: key);

  @override
  State<PizzaDetailsPage> createState() => _PizzaDetailsPageState();
}

class _PizzaDetailsPageState extends State<PizzaDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.pizza.name} Details',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            // color: Theme.of(context).appBarTheme.color,
          ),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 250,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                widget.pizza.imageUrl,
                fit: BoxFit.fill,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(
              height: 50,
            ),
            Text(
              'Pizza Name:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Text(
              widget.pizza.name,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 10),
            Text(
              'Price:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              NumberFormat.currency(symbol: '₹').format(widget.pizza.price),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 10),
            Text(
              'Description:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              'Lorem ipsum dolor sit ame,Quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            // Add more details or customization based on your requirements
          ],
        ),
      ),
    );
  }
}

class PizzaListPage extends StatefulWidget {
  const PizzaListPage({Key? key}) : super(key: key);

  @override
  State<PizzaListPage> createState() => _PizzaListPageState();
}

class Pizza {
  final String name;
  final double price;
  String imageUrl;

  Pizza({required this.name, required this.price, required this.imageUrl});
}

class _PizzaListPageState extends State<PizzaListPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    )..forward(); // Start the animation forward when the page loads
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  final List<Pizza> pizzaTypes = [
    Pizza(
      name: 'Margherita',
      price: 109,
      imageUrl:
          'https://t3.ftcdn.net/jpg/00/27/57/96/360_F_27579652_tM7V4fZBBw8RLmZo0Bi8WhtO2EosTRFD.jpg',
    ),
    Pizza(
        name: 'Pepperoni',
        price: 129,
        imageUrl:
            'https://www.tasteofhome.com/wp-content/uploads/2021/01/New-York-Style-Pizza_EXPS_FT20_105578_F_1217_1.jpg?w=1200'),
    Pizza(
        name: 'Vegetarian',
        price: 199,
        imageUrl:
            'https://riotfest.org/wp-content/uploads/2016/10/151_1stuffed_crust_pizza.jpg'),
    Pizza(
        name: 'Hawaiian',
        price: 199,
        imageUrl:
            'https://i.pinimg.com/originals/4e/41/f0/4e41f0911d9b5947b072708a13df6a13.jpg'),
    Pizza(
        name: 'BBQ Chicken',
        price: 149,
        imageUrl:
            'https://th.bing.com/th/id/R.e15b9f765329d00f228862fa3bb160fc?rik=NtmKcLBnQgjzKA&riu=http%3a%2f%2fwww.teaforturmeric.com%2fwp-content%2fuploads%2f2017%2f11%2ftandoori-chicken-pizza-4442.jpg&ehk=4%2b4YFv4wi2cGK4TRegy87PLiLJMVwoJmn3Q9GMiSZ3g%3d&risl=&pid=ImgRaw&r=0'),
    Pizza(
        name: 'Meat Lovers',
        price: 159,
        imageUrl:
            'https://ikneadtoeat.com/wp-content/uploads/2020/02/Tandoori-Chicken-Pizza-1.jpg'),
    Pizza(
        name: 'Mushroom Lovers',
        price: 119,
        imageUrl:
            'https://th.bing.com/th/id/OIP.H3SS46CTz7kx6wh5Z4i9aAHaE8?w=1200&h=800&rs=1&pid=ImgDetMain'),
    Pizza(
        name: 'Supreme',
        price: 169,
        imageUrl:
            'https://th.bing.com/th/id/OIP.4j6zJVUpFmWwnJ8SBKXAgwHaGg?w=1000&h=878&rs=1&pid=ImgDetMain'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pizza List'),
        ),
        body: ListView.builder(
          itemCount: pizzaTypes.length,
          itemBuilder: (context, index) {
            final pizza = pizzaTypes[index];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PizzaDetailsPage(pizza: pizza),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Hero(
                            tag: pizza.name,
                            child: Material(
                              borderRadius: BorderRadius.circular(15.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Image(
                                  image: NetworkImage(pizza.imageUrl),
                                  fit: BoxFit.cover,
                                  height: 150.0,
                                  // Add placeholder and error widgets (optional)
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pizza.name,
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                "Price: ₹${pizza.price.toStringAsFixed(2)}",
                                style: const TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
