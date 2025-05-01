import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/model/Product.dart';
import 'package:inscri_ecommerce/screens/details_produit/components/show_add_review_model.dart';

class DescriptionReview extends StatefulWidget {
  final Product product;
  final Future<void> Function()? onRefresh;

  DescriptionReview({required this.product,required this.onRefresh});

  @override
  _DescriptionReviewState createState() => _DescriptionReviewState();
}

class _DescriptionReviewState extends State<DescriptionReview> {
  bool isDescriptionExpanded = false;
  bool isReviewsExpanded = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildExpandableSection(
            title: 'Description',
            isExpanded: isDescriptionExpanded,
            onTap: () =>
                setState(() => isDescriptionExpanded = !isDescriptionExpanded),
            content: Text(
              widget.product.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16)
            ),
          ),
          SizedBox(height: 10),
          _buildExpandableSection(
            title: 'Reviews',
            isExpanded: isReviewsExpanded,
            onTap: () => setState(() => isReviewsExpanded = !isReviewsExpanded),
            content: Column(
              children: [
                //add review button
                Align(
                  alignment: Alignment.centerRight,
                  child: OutlinedButton.icon(
                    onPressed: () {showAddReviewModal(context,ProductID:widget.product.id,onRefresh:widget.onRefresh);}, // Add action later
                    icon: Icon(Icons.rate_review_outlined,
                        color: Color(0xFFDB3022)),
                    label: Text(
                      "Write a review",
                      style: TextStyle(color: Color(0xFFDB3022)),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Color(0xFFDB3022)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                    ),
                  ),
                ),

                SizedBox(height: 10),
                widget.product.reviews.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: widget.product.reviews.map<Widget>((review) {
                          final comment = review['comment'] ?? '';

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Text(
                              "- $comment",
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14)
                            ),
                          );
                        }).toList(),
                      )
                    : Text(
                        "No reviews available.",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14)
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableSection({
    required String title,
    required bool isExpanded,
    required VoidCallback onTap,
    required Widget content,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFFF3F3F6), width: 1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Color(0xFF33302E),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  size: 20,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: content,
          ),
      ],
    );
  }
}
