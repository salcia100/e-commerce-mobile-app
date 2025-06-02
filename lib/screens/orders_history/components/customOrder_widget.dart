import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/api/checkout_api.dart';
import 'package:inscri_ecommerce/model/custom_orders.dart';
import 'package:inscri_ecommerce/screens/checkout/CheckoutWebView.dart';
import 'package:inscri_ecommerce/screens/customised_orders/components/fullScreenImage.dart';
import 'package:inscri_ecommerce/utils/toast.dart ';

class CustomOrderWidget extends StatefulWidget {
  final CustomOrders order;
  final VoidCallback onConfirmVendor;
  final VoidCallback onCancelVendor;

  const CustomOrderWidget({
    required this.order,
    required this.onConfirmVendor,
    required this.onCancelVendor,
  });

  @override
  State<CustomOrderWidget> createState() => _CustomOrderWidgetState();
}

class _CustomOrderWidgetState extends State<CustomOrderWidget> {
  bool _isExpanded = false; // Variable to track the expanded state

  void payOrder() async {
    CheckoutApi api = CheckoutApi();
    var id = widget.order.order_id;
    print('URL de paiement Stripe: $id');
    var result = await api.checkoutPendingOrder(widget.order.order_id);

    if (result != null) {
      // L'URL de paiement Stripe a été récupérée avec succès
      print('URL de paiement Stripe: $result');

      // Naviguer vers la page CheckoutAccepted
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CheckoutWebView(paymentUrl: result),
          ));
    } else {
      print("Veuillez remplir le formulaire et accepter les conditions !");
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
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
              Text(
                'Custom Order ⭐ #${widget.order.id}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('title: ${widget.order.title}'),
              Text('Quantity: ${widget.order.quantity}'),
              Text('budget: \$${widget.order.budget}'),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      margin: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .cardColor, 
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Vendor Info
                          Row(
                            children: [
                              Icon(Icons.store, color: Colors.deepPurple),
                              SizedBox(width: 8),
                              Text(
                                widget.order.vendor?.name ?? "No vendor yet",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color, 
                                ),
                              ),
                            ],
                          ),

                          if(widget.order.status == 'accepted_by_vendor')
                          Row(
                            children: [
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.green,
                                  side: BorderSide(color: Colors.green),
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                ),
                                onPressed: widget.onConfirmVendor,
                                child: Text("Confirm"),
                              ),
                              SizedBox(width: 8),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.red,
                                  side: BorderSide(color: Colors.red),
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                ),
                                onPressed: widget.onCancelVendor,
                                child: Text("Cancel"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.order.status,
                    style: TextStyle(
                      color: widget.order.status == 'confirmed'
                          ? Colors.orange
                          : widget.order.status == 'paid'
                              ? Colors.blue
                              : widget.order.status == 'canceled'
                                  ? Colors.red
                                  : widget.order.status == 'accepted_by_vendor'
                                      ? Colors.green
                                      : Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (widget.order.status == 'confirmed')
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              title: Text('Choose payment method'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ElevatedButton.icon(
                                    icon: Icon(Icons.credit_card),
                                    label: Text('Pay with Stripe'),
                                    onPressed: () {
                                      payOrder();
                                      Navigator.pop(context);
                                    },
                                  ),
                                  SizedBox(height: 10),
                                  ElevatedButton.icon(
                                    icon: Icon(Icons.delivery_dining),
                                    label: Text('Pay on delivery'),
                                    onPressed: () async {
                                      Navigator.pop(context);
                                        await CheckoutApi.payOnDelivery(
                                          widget.order.order_id);
                                      successToast(
                                          "Your order has been successfully processed with cash on delivery.");
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: const Text('Pay Now'),
                    ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isExpanded = !_isExpanded; // Toggle the expanded state
                      });
                    },
                    child: Text(_isExpanded ? 'Hide Details' : 'Details'),
                  ),
                ],
              ),
              if (_isExpanded) ...[
                SizedBox(height: 10), // Adds space before the product list
                Divider(color: Colors.grey), // Optional separator
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FullScreenImage(imageUrl: widget.order.image),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12), // Coins arrondis
                      child: Image.network(
                        widget.order.image,
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Description: ${widget.order.description}'),
                        Text('Material: ${widget.order.material}'),
                        Text('Color: ${widget.order.color}'),
                      ]),
                ),
              ],
            ],
          ),
        ));
  }
}
