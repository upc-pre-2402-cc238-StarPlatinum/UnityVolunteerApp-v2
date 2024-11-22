import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  final VoidCallback onPaymentSuccess;
  PaymentScreen({required this.onPaymentSuccess});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Payment'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Text(
                  'Enter Payment Details',
                  style: TextStyle(fontSize: 18),
                ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                labelText: 'Card Number',
                border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Expiration Date',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'CVV',
                  border: OutlineInputBorder(),
              ),
              obscureText: true,
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  onPaymentSuccess();
                  Navigator.of(context).pop(); // Return to Profile Screen
                },
                child: Text('Pay'),
              ),
            ],
          ),
    )
    );
  }
}
