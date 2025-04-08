import 'package:flutter/material.dart';

class VendorOrdersScreen extends StatelessWidget {



  // Static list of orders for now
  final List<Map<String, dynamic>> orders = [
    {
      "id": 6,
      "user_id": 2,
      "name": "sssssss",
      "phone": "ssss",
      "total_quantity": 3,
      "total_price": "1300.00",
      "status": "PENDING",
      "shipping_address": "ssssss",
      "created_at": "2025-03-25T10:55:41.000000Z",
      "updated_at": "2025-03-25T10:55:41.000000Z",
      "order_item": [
        {
          "id": 82,
          "order_id": 6,
          "product_id": 20,
          "quantity": 1,
          "price": "500.00",
          "created_at": "2025-03-25T10:55:41.000000Z",
          "updated_at": "2025-03-25T10:55:41.000000Z",
          "product": {
            "id": 20,
            "name": "fg",
            "description": "fffffffff",
            "price": "22.00",
            "stock": 22,
            "image":
                "http://127.0.0.1:8000/storage/product/9YWADSpw4gwLyooTVEdsmdiYwQQJ1CkYPuBz6Y7O.jpg",
            "created_at": "2025-04-07T19:34:32.000000Z",
            "updated_at": "2025-04-07T19:34:32.000000Z",
            "user_id": 2
          }
        }
      ]
    }
    // You can add more orders here if needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: const Text(
        'Orders to Fulfill ',
        style: TextStyle(
          color: Color(0xFF1D1F22),
          fontSize: 18,
          fontFamily: 'Product Sans',
        ),
      ),
      centerTitle: true,
    ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'you dont get orders for now ! 🤷‍♂️😭',
              style: TextStyle(fontSize: 24),
            ),
            // Add your order display code here
          ],
        ),
      ),
    );
  }
}
