import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/api/Product_api.dart';
import 'package:inscri_ecommerce/utils/toast.dart';

void showAddReviewModal(BuildContext context, {required int ProductID ,required Future<void> Function()? onRefresh}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
    ),
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: AddReviewBody(ProductID: ProductID,onRefresh: onRefresh),
    ),
  );
}

class AddReviewBody extends StatefulWidget {
  final int ProductID;
    final Future<void> Function()? onRefresh;
  const AddReviewBody({Key? key, required this.ProductID,required this.onRefresh}) : super(key: key);

  @override
  State<AddReviewBody> createState() => _AddReviewBodyState();
}

class _AddReviewBodyState extends State<AddReviewBody> {
  String review = '';
  final TextEditingController _controller = TextEditingController();
  ProductApi productApi = ProductApi();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Write a Review',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          TextField(
            controller: _controller,
            onChanged: (value) {
              setState(() {
                review = value;
              });
            },
            decoration: InputDecoration(
              labelText: 'Your Review',
              border: OutlineInputBorder(),
            ),
            maxLines: 5,
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              try {
                await productApi.addReview(
                    widget.ProductID, review); // Assuming updateProduct handles adding review
                successToast("review added successfully !");
              } catch (e) {
                errorToast("Error while adding review!");
              }
              Navigator.pop(context);
              widget.onRefresh!(); // Call the refresh function after adding the review
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Color(0xFFDB3022)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(
              'Submit Review',
              style: TextStyle(color: Color(0xFFDB3022)),
            ),
          )
        ],
      ),
    );
  }
}
