import 'package:flutter/material.dart';
import 'package:soapy_app/pages/Products/product_payment.dart';
import 'package:soapy_app/pages/customs/colors.dart';

class ViewcartProducts extends StatefulWidget {
  final List<int> quantities;
  final List<String> imagePaths;
  final List<String> flavours;

  ViewcartProducts({
    required this.quantities,
    required this.imagePaths,
    required this.flavours,
    required List initialQuantities,
  });

  @override
  _ViewcartProductsState createState() => _ViewcartProductsState();
}

class _ViewcartProductsState extends State<ViewcartProducts> {
  late List<int> quantities;
  final int pricePerItem = 360; // Price for one quantity of an item

  @override
  void initState() {
    super.initState();
    quantities =
        List.from(widget.quantities); // Copy quantities to manage local state
  }

  void incrementQuantity(int index) {
    setState(() {
      quantities[index]++;
    });
  }

  void decrementQuantity(int index) {
    setState(() {
      if (quantities[index] > 1) {
        // Ensure quantity doesn't go below 1
        quantities[index]--;
      }
    });
  }

  void setQuantityToZero(int index) {
    setState(() {
      quantities[index] = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Prepare all items
    final itemsWithQuantity = [
      for (int i = 0; i < widget.imagePaths.length; i++)
        {
          'index': i,
          'imagePath': widget.imagePaths[i],
          'flavour': widget.flavours[i],
          'quantity': quantities[i]
        }
    ];

    // Filter out items with quantity > 0 for display
    final itemsToDisplay = itemsWithQuantity
        .where((item) => (item['quantity'] as int) > 0)
        .toList();

    if (itemsToDisplay.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('View Cart'),
        ),
        body: Center(
          child: Text('No items to display'),
        ),
      );
    }

    // Calculate subtotal
    final subtotal = itemsToDisplay.fold<int>(
      0,
      (total, item) => total + (item['quantity'] as int) * pricePerItem,
    );

    // Calculate GST and discount
    final gst = subtotal * 0.02;
    final discount = subtotal * 0.05;
    final totalAmount = subtotal + gst - discount;

    // Determine how many items have been selected
    final selectedItemCount = itemsToDisplay.length;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0), // Preferred height of the AppBar
        child: AppBar(
          title: Center(
            child: Text(
              'View Cart',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22, // Customize text size
              ),
            ),
          ),
          backgroundColor: Mycolor.maincolor, // AppBar background color
          elevation: 0, // Removes the shadow under the AppBar
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30), // Bottom border radius
            ),
          ),
          // Optionally add more widgets or styles
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  ListView.builder(
                    itemCount: itemsToDisplay.length,
                    shrinkWrap:
                        true, // Use only the space required by the items
                    physics:
                        NeverScrollableScrollPhysics(), // Disable scrolling within the ListView
                    itemBuilder: (context, index) {
                      final item = itemsToDisplay[index];
                      final itemIndex = item['index'] as int;
                      final totalAmount = quantities[itemIndex] *
                          pricePerItem; // Calculate total amount

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                item['imagePath'] as String,
                                height: 160,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['flavour'] as String,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    '$totalAmount INR',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Container(
                                        width: 20, // Adjust size as needed
                                        height: 20, // Adjust size as needed
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.remove,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          padding: EdgeInsets.zero,
                                          onPressed: () =>
                                              decrementQuantity(itemIndex),
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        '${quantities[itemIndex]}',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      SizedBox(width: 8),
                                      Container(
                                        width: 20, // Adjust size as needed
                                        height: 20, // Adjust size as needed
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          shape: BoxShape.circle,
                                        ),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          padding: EdgeInsets.zero,
                                          onPressed: () =>
                                              incrementQuantity(itemIndex),
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      IconButton(
                                        icon: Icon(Icons.cancel),
                                        onPressed: () =>
                                            setQuantityToZero(itemIndex),
                                      ),
                                      Spacer(),
                                      Text(
                                        '$totalAmount INR', // Display the total amount
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  if (selectedItemCount >=
                      1) // Show summary container if 1 or more items are selected
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      width: MediaQuery.of(context).size.width *
                          0.9, // 90% of screen width
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Summary',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Subtotal:',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '$subtotal INR',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'GST (2%):',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '${gst.toStringAsFixed(2)} INR',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Discount (5%):',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.red,
                                ),
                              ),
                              Text(
                                '-${discount.toStringAsFixed(2)} INR',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Amount:',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${totalAmount.toStringAsFixed(2)} INR',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductPayment(
                                totalAmount: totalAmount,
                              )));
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width *
                      0.8, // Full width of the screen
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Mycolor.maincolor,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  // Background color of the button container
                  child: Center(
                    child: Text(
                      'Book Now',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
