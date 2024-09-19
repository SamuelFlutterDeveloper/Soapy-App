// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: QuantitySelector(),
//     );
//   }
// }

// class QuantitySelector extends StatefulWidget {
//   @override
//   _QuantitySelectorState createState() => _QuantitySelectorState();
// }

// class _QuantitySelectorState extends State<QuantitySelector> {
//   int quantity = 0;

//   void incrementQuantity() {
//     setState(() {
//       quantity++;
//     });
//   }

//   void decrementQuantity() {
//     setState(() {
//       if (quantity > 0) {
//         quantity--;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Quantity Selector'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Text(
//             //   'Quantity: $quantity',
//             //   style: TextStyle(fontSize: 24),
//             // ),
//             SizedBox(height: 20),
//             quantity == 0
//                 ? GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         incrementQuantity();
//                       });
//                     },
//                     child: Container(
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                       decoration: BoxDecoration(
//                         color: Colors.red,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Text(
//                         'Add',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                         ),
//                       ),
//                     ),
//                   )
//                 : Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       IconButton(
//                         icon: Icon(Icons.remove),
//                         onPressed: decrementQuantity,
//                       ),
//                       Text(
//                         '$quantity',
//                         style: TextStyle(fontSize: 24),
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.add),
//                         onPressed: incrementQuantity,
//                       ),
//                     ],
//                   ),

//           ],
//         ),
//       ),
//       floatingActionButton: quantity > 0
//           ? Padding(
//               padding: EdgeInsets.only(
//                   bottom: MediaQuery.of(context).size.height * 0.03),
//               child: Container(
//                 width: MediaQuery.of(context).size.width *
//                     0.7, // 70% of screen width
//                 height: 50,
//                 child: FloatingActionButton(
//                   onPressed: () {
//                     // Define what happens when FAB is pressed
//                   },
//                   backgroundColor: const Color.fromARGB(255, 36, 197, 42),
//                   child: Center(
//                     child: Text(
//                       '$quantity items added   View Cart>',
//                       style: TextStyle(
//                           fontSize: 14, // Adjust size for better fit
//                           color: Colors.white),
//                     ),
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8), // Rounded corners
//                   ),
//                 ),
//               ),
//             )
//           : null, // Hide FAB if quantity is 0
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       // Center FAB at the bottom
//     );
//   }
// }
//-----------------------------------------------------------------
import 'package:flutter/material.dart';

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  // Sample data for checkboxes
  final List<String> _items = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];
  final List<bool> _selected = [
    false,
    false,
    false,
    false
  ]; // Track selected state
  String _selectedItem = 'Select Items';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dropdown Checkbox Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _showCheckboxDialog, // Show dialog on button press
          child: Text(_selectedItem),
        ),
      ),
    );
  }

  void _showCheckboxDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Select Items'),
              content: Container(
                width: double.maxFinite, // Ensures it takes available width
                child: ListView.builder(
                  shrinkWrap:
                      true, // Makes ListView take only as much space as it needs
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                      title: Text(_items[index]),
                      value: _selected[index],
                      onChanged: (bool? value) {
                        setState(() {
                          _selected[index] =
                              value ?? false; // Update selected state
                        });
                      },
                    );
                  },
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close dialog without saving
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                    setState(() {
                      // Update the selected item with the selected checkboxes
                      _selectedItem = _selected
                          .asMap()
                          .entries
                          .where((entry) => entry.value)
                          .map((entry) => _items[entry.key])
                          .join(', ');

                      if (_selectedItem.isEmpty) {
                        _selectedItem =
                            'Select Items'; // Set default text if nothing is selected
                      }
                    });
                  },
                  child: const Text('Done'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
