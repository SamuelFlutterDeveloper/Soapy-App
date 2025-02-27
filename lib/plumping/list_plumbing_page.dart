import 'package:flutter/material.dart';
import 'package:soapy_app/pages/customs/colors.dart';
import 'package:soapy_app/pest%20control/cart_page.dart';

class ListPlumbingPage extends StatefulWidget {
  final String categories;
  const ListPlumbingPage({super.key, required this.categories});

  @override
  State<ListPlumbingPage> createState() => _ListPlumbingPageState();
}

class _ListPlumbingPageState extends State<ListPlumbingPage> {
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
      case 'Bath Fittings':
        return [
          {
            'title': 'Shower Installation & Repair',
            'rating': 4.7,
            'reviews': '15K reviews',
            'price': 799,
            'features': [
              'Installation of new showers',
              'Leak fixing and water pressure adjustment',
            ],
            'image': 'assets/images/Dish-slider1.png',
          },
          {
            'title': 'Tap Replacement & Fixing',
            'rating': 4.8,
            'reviews': '20K reviews',
            'price': 499,
            'features': [
              'Fixing leaking taps',
              'Installation of new faucets',
            ],
            'image': 'assets/images/6.jpg',
          },
        ];

      case 'Basin & sink':
        return [
          {
            'title': 'Sink Unclogging & Repair',
            'rating': 4.75,
            'reviews': '18K reviews',
            'price': 599,
            'features': [
              'Removal of blockages',
              'Leak detection and fixing',
            ],
            'image': 'assets/images/Dish-slider2.png',
          },
          {
            'title': 'Basin Installation & Replacement',
            'rating': 4.8,
            'reviews': '22K reviews',
            'price': 1499,
            'features': [
              'Installation of new basin & sink fittings',
              'Replacement of damaged basins & plumbing adjustments',
            ],
            'image': 'assets/images/6.jpg',
          },
        ];

      case 'Grouting':
        return [
          {
            'title': 'Tile Grouting & Repair',
            'rating': 4.6,
            'reviews': '10K reviews',
            'price': 1199,
            'features': [
              'Fixing broken grout',
              'Sealing and cleaning old grout lines',
            ],
            'image': 'assets/images/5.jpg',
          },
          {
            'title': 'Epoxy Grouting Service',
            'rating': 4.8,
            'reviews': '12K reviews',
            'price': 1899,
            'features': [
              'Waterproof and stain-resistant grouting',
              'Perfect for bathrooms, kitchens, and pools',
            ],
            'image': 'assets/images/1.jpg',
          },
        ];

      case 'Water filter':
        return [
          {
            'title': 'Water Purifier Installation',
            'rating': 4.85,
            'reviews': '30K reviews',
            'price': 1299,
            'features': [
              'Installation of new RO filters',
              'Leak and flow check after installation',
            ],
            'image': 'assets/images/2.png',
          },
          {
            'title': 'Water Purifier Repair & Maintenance',
            'rating': 4.9,
            'reviews': '40K reviews',
            'price': 899,
            'features': [
              'Cartridge replacement',
              'Filter cleaning and repair',
            ],
            'image': 'assets/images/1.jpg',
          },
        ];

      case 'Drainage':
        return [
          {
            'title': 'Drain Cleaning & Unclogging',
            'rating': 4.7,
            'reviews': '35K reviews',
            'price': 799,
            'features': [
              'Clearing blocked drains',
              'Checking for pipe damage',
            ],
            'image': 'assets/images/Dish-slider1.png',
          },
          {
            'title': 'Sewer Line Inspection & Cleaning',
            'rating': 4.9,
            'reviews': '22K reviews',
            'price': 2499,
            'features': [
              'Advanced camera inspection for blockages',
              'High-pressure cleaning of sewer pipes',
            ],
            'image': 'assets/images/Dish-slider2.png',
          },
        ];

      case 'Toilet':
        return [
          {
            'title': 'Toilet Repair & Fixing',
            'rating': 4.8,
            'reviews': '25K reviews',
            'price': 899,
            'features': [
              'Fixing flush issues',
              'Replacing old toilet seats',
            ],
            'image': 'assets/images/3.jpg',
          },
          {
            'title': 'New Toilet Installation',
            'rating': 4.9,
            'reviews': '28K reviews',
            'price': 2999,
            'features': [
              'Installation of new toilets',
              'Leakage and pipe fitting check',
            ],
            'image': 'assets/images/1.jpg',
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
          'Plumbing ',
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
