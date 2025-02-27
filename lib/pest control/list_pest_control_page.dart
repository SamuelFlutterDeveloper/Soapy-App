import 'package:flutter/material.dart';
import 'package:soapy_app/pages/customs/colors.dart';
import 'package:soapy_app/pest%20control/cart_page.dart';

class ListPestControlPage extends StatefulWidget {
  


  const ListPestControlPage({super.key});

  @override
  State<ListPestControlPage> createState() => _ListPestControlPageState();
}

class _ListPestControlPageState extends State<ListPestControlPage> {
  List<int> counts = List.generate(3, (index) => 0);
  List<int> quantities =
      List.generate(3, (index) => 0); // Track quantities for each item

  void incrementQuantity(int index) {
    setState(() {
      quantities[index]++;
    });
  }

  void decrementQuantity(int index) {
    setState(() {
      if (quantities[index] > 0) {
        quantities[index]--;
      }
    });
  }

  final List<Map<String, dynamic>> pestControlServices = [
    {
      'title': 'Pest control (includes utensil removal)',
      'rating': 4.79,
      'reviews': '98K reviews',
      'price': '₹1,098',
      'features': [
        'Treatment will be completed in 2 visits with 2 weeks of gap',
        'We\'ll remove utensils before the service begins'
      ],
      'image': 'assets/images/first.png',
    },
    {
      'title': 'Pest control (excludes utensil removal)',
      'rating': 4.80,
      'reviews': '63K reviews',
      'price': '₹899',
      'features': [
        'Treatment will be completed in 2 visits with 2 weeks of gap',
        'Excludes removal of utensils & objects before the service'
      ],
      'image': 'assets/images/four.jpg',
    },
    {
      'title': ' Apartment Pest control (includes utensil removal)',
      'rating': 4.85,
      'reviews': '25K reviews',
      'price': '₹1499',
      'features': [
        'Spray treatment followed by gel treatment after 2 weeks',
        "We'll remove utensils before the service begin",
      ],
      'image': 'assets/images/five.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Pest Control',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: ListView.builder(
                  itemCount: pestControlServices.length,
                  shrinkWrap: true, // Important: Fixes the height issue
                  physics:
                      const NeverScrollableScrollPhysics(), // Disables scrolling inside ListView
                  itemBuilder: (context, index) {
                    final service = pestControlServices[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            spreadRadius: 1,
                            offset: const Offset(0, 2),
                          )
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  service['title'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.star,
                                        size: 16, color: Colors.amber),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${service['rating']} (${service['reviews']})',
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Starts at ${service['price']}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: (service['features']
                                          as List<String>)
                                      .map((feature) => Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 4),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text('• ',
                                                    style: TextStyle(
                                                        color: Colors.black)),
                                                Expanded(
                                                  child: Text(
                                                    feature,
                                                    style: const TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ))
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  service['image'],
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  quantities[index] == 0
                                      ? GestureDetector(
                                          onTap: () {
                                            incrementQuantity(index);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4, horizontal: 12),
                                            decoration: BoxDecoration(
                                              color: Colors.blue.shade50,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: const Text(
                                              'Add',
                                              style: TextStyle(
                                                  color: Mycolor.maincolor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                              icon: Icon(
                                                Icons.remove,
                                                size: 15,
                                              ),
                                              onPressed: () =>
                                                  decrementQuantity(index),
                                            ),
                                            Text(
                                              '${quantities[index]}',
                                              style: TextStyle(fontSize: 15),
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                Icons.add,
                                                size: 15,
                                              ),
                                              onPressed: () =>
                                                  incrementQuantity(index),
                                            ),
                                          ],
                                        ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: quantities.any((qty) => qty > 0)
          ? Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 50,
                child: FloatingActionButton(
                  onPressed: () {
                    print('111111111111111111111111111111111111111');
                    List<Map<String, dynamic>> cartItems = [];
                    for (int i = 0; i < pestControlServices.length; i++) {
                      if (quantities[i] > 0) {
                        cartItems.add({
                          'image': pestControlServices[i]['image'],
                          'title': pestControlServices[i]['title'],
                          'price': int.parse(pestControlServices[i]['price']
                              .replaceAll('₹', '')
                              .replaceAll(',', '')),
                          'quantity': quantities[i],
                        });
                      }
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CartPage(cartItems: cartItems)),
                    );
                  },
                  backgroundColor: const Color.fromARGB(255, 36, 197, 42),
                  child: Center(
                    child: Text(
                      '${quantities.reduce((a, b) => a + b)} items added   View Cart>',
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
