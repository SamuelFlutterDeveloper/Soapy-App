import 'package:flutter/material.dart';
import 'package:soapy_app/pages/app_page.dart';
import 'package:soapy_app/pages/customs/colors.dart';
import 'package:soapy_app/pages/customs/dailoguebox.dart';

import 'package:soapy_app/pages/home.dart'; // Ensure you import your Home page

class ProductPayment extends StatefulWidget {
  final double totalAmount; // Pass the total amount from the previous screen

  const ProductPayment({super.key, required this.totalAmount});

  @override
  State<ProductPayment> createState() => _ProductPaymentState();
}

class _ProductPaymentState extends State<ProductPayment> {
  bool _isLoading = false; // Show loading spinner and overlay
  int _selectedPaymentMethod = 0; // Track selected payment method

  void _handlePayment() async {
    setState(() {
      _isLoading = true; // Show loading spinner and overlay
    });

    await Future.delayed(Duration(seconds: 2)); // Simulate a 2-second delay

    setState(() {
      _isLoading = false; // Hide loading spinner and overlay
    });

    // Show the payment success dialog
    DialogHelper.showSuccessDialog(
      context,
      title: "Payment Successful",
      message: "Your order has been booked successfully!",
      totalAmount: widget.totalAmount, // Pass the total amount here
      onDone: () {
        Navigator.of(context).pop(); // Close the dialog
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => AppPage()), // Go to Home
            (route) => false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0), // Preferred height of the AppBar
        child: AppBar(
          title: Center(
            child: Text(
              'Payment',
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
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                // Text(
                //   'Total Amount: ₹${widget.totalAmount.toStringAsFixed(2)}',
                //   style: TextStyle(
                //     fontSize: 20,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                SizedBox(height: 20),
                _buildPaymentOption(
                    1, 'Amazon Pay', 'assets/images/amazonpay.png', 50, 50),
                SizedBox(height: 16),
                _buildPaymentOption(
                    2, 'Google Pay', 'assets/images/gpay.png', 40, 40),
                SizedBox(height: 16),
                _buildPaymentOption(
                    3, 'Paytm', 'assets/images/paytm.png', 45, 45),
                SizedBox(height: 16),
                _buildPaymentOption(
                    4, 'PhonePe', 'assets/images/phonepay.png', 55, 55),
                Spacer(),
                _buildPayButton(),
              ],
            ),
          ),
          if (_isLoading)
            Container(
              color:
                  Colors.black.withOpacity(0.5), // Semi-transparent background
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(int value, String text, String imagePath,
      double imageWidth, double imageHeight) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Radio<int>(
            value: value,
            groupValue: _selectedPaymentMethod,
            activeColor: Colors.blue,
            onChanged: (int? newValue) {
              setState(() {
                _selectedPaymentMethod = newValue!;
              });
            },
          ),
          SizedBox(width: 20),
          Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color:
                  _selectedPaymentMethod == value ? Colors.black : Colors.grey,
              fontWeight: _selectedPaymentMethod == value
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
          Spacer(),
          Image.asset(
            imagePath,
            width: imageWidth,
            height: imageHeight,
          ),
        ],
      ),
    );
  }

  Widget _buildPayButton() {
    bool isSelected = _selectedPaymentMethod != 0;

    return GestureDetector(
      onTap: () {
        if (isSelected) {
          _handlePayment(); // Trigger payment logic with loading spinner
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("No Payment Method Selected"),
                content:
                    Text("Please select a payment method before proceeding."),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Align(
          alignment: Alignment.center,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: isSelected ? Mycolor.maincolor : Colors.grey,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text(
              'Pay ${widget.totalAmount.toStringAsFixed(2)} INR',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
