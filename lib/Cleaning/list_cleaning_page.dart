import 'package:flutter/material.dart';
import 'package:soapy_app/pages/customs/colors.dart';
import 'package:soapy_app/pest%20control/cart_page.dart';

class ListCleaningPage extends StatefulWidget {
  final String categories;
  const ListCleaningPage({super.key, required this.categories});

  @override
  State<ListCleaningPage> createState() => _ListCleaningPageState();
}

class _ListCleaningPageState extends State<ListCleaningPage> {
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

  /// Returns a list of services based on the selected category
  List<Map<String, dynamic>> getServicesForCategory() {
    switch (widget.categories) {
      case 'Bathroom':
        return [
          {
            'title': 'Classic Cleaning (2 Bathrooms)',
            'rating': 4.79,
            'reviews': '98K reviews',
            'price': 1098,
            'features': [
              'Deep cleaning of tiles, floor, and WC',
              'Removal of hard water stains and dirt',
            ],
            'image': 'assets/images/first.png',
          },
          {
            'title': 'Intense Cleaning (2 Bathrooms)',
            'rating': 4.80,
            'reviews': '63K reviews',
            'price': 899,
            'features': [
              'Includes all Classic Cleaning features',
              'Specialized treatment for mold and mildew',
            ],
            'image': 'assets/images/four.jpg',
          },
          {
            'title': 'Classic Cleaning (3 Bathrooms)',
            'rating': 4.85,
            'reviews': '25K reviews',
            'price': 1499,
            'features': [
              'Includes all Classic Cleaning (2 Bathrooms) features',
              'Customized cleaning solution for larger bathrooms',
            ],
            'image': 'assets/images/five.jpg',
          },
        ];

      case 'Kitchen':
        return [
          {
            'title': 'Basic Kitchen Cleaning',
            'rating': 4.7,
            'reviews': '45K reviews',
            'price': 999,
            'features': [
              'Cleaning of countertops, cabinets, and sink',
              'Degreasing of exhaust fan & tiles',
            ],
            'image': 'assets/images/Dish-slider1.png',
          },
          {
            'title': 'Deep Kitchen Cleaning',
            'rating': 4.85,
            'reviews': '60K reviews',
            'price': 1599,
            'features': [
              'Includes all Basic Kitchen Cleaning features',
              'Intense scrubbing of chimneys and stove areas',
            ],
            'image': 'assets/images/Dish-slider2.png',
          },
        ];

      case 'Full Home':
        return [
          {
            'title': 'Full Home Cleaning (2 BHK)',
            'rating': 4.9,
            'reviews': '80K reviews',
            'price': 3499,
            'features': [
              'Complete deep cleaning of all rooms, kitchen, and bathrooms',
              'Vacuuming and mopping of floors',
            ],
            'image': 'assets/images/1.jpg',
          },
          {
            'title': 'Full Home Cleaning (3 BHK)',
            'rating': 4.95,
            'reviews': '95K reviews',
            'price': 4499,
            'features': [
              'Includes all 2 BHK Cleaning features',
              'Extra care for furniture & glass surfaces',
            ],
            'image': 'assets/images/2.png',
          },
        ];

      case 'Sofa & Carpet':
        return [
          {
            'title': 'Sofa Cleaning (5 Seater)',
            'rating': 4.8,
            'reviews': '40K reviews',
            'price': 1299,
            'features': [
              'Shampoo cleaning and drying',
              'Removal of stains and odors',
            ],
            'image': 'assets/images/5.jpg',
          },
          {
            'title': 'Carpet Cleaning (Large)',
            'rating': 4.75,
            'reviews': '30K reviews',
            'price': 999,
            'features': [
              'Deep vacuuming and shampooing',
              'Removes dirt, dust mites, and allergens',
            ],
            'image': 'assets/images/6.jpg',
          },
        ];

      default:
        return []; // Empty list if no category matches
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> services = getServicesForCategory();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Cleaning ',
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
                  itemCount: services.length,
                  shrinkWrap: true, // Important: Fixes the height issue
                  physics:
                      const NeverScrollableScrollPhysics(), // Disables scrolling inside ListView
                  itemBuilder: (context, index) {
                    final service = services[index];
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
                                  'Starts at ₹${service['price']}',
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
                    for (int i = 0; i < services.length; i++) {
                      if (quantities[i] > 0) {
                        cartItems.add({
                          'image': services[i]['image'],
                          'title': services[i]['title'],
                          'price': services[i]['price'],
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
