import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/model/sale.dart';

class SalesItem extends StatefulWidget {
  final Sale sale;

  const SalesItem({Key? key, required this.sale}) : super(key: key);

  @override
  State<SalesItem> createState() => _SalesItemState();
}

class _SalesItemState extends State<SalesItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final product = widget.sale.product;

    return AnimatedSize(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,//color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 0, 0, 0),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Image produit
            /*Image.network(
              product.image,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.broken_image);
              },
            ),

            SizedBox(height: 8),*/
            Text(
              product.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Order ID: ${widget.sale.id}'),
              Text('Client: ${widget.sale.name}'),
            
            Text('Quantity Sold: ${widget.sale.quantity}'),
            SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.stock > 0 ? "Available" : "Out of Stock",
                  style: TextStyle(
                    color: product.stock > 0 ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  child: Text(_isExpanded ? "Hide Details" : "Details"),
                ),
              ],
            ),

            if (_isExpanded) ...[
              Divider(color: Colors.grey),
              SizedBox(height: 10),
              Text(
                product.description,
                style: TextStyle(color: Colors.grey[700]),
              ),
              SizedBox(height: 10),
              Text('Price: \$${product.price.toStringAsFixed(2)}'),
              Text('Stock: ${product.stock}'),
              Text('Date: ${widget.sale.date}'),
              SizedBox(height: 10),
            ],
          ],
        ),
      ),
    );
  }
}
