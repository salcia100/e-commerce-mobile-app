import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/model/Product.dart';

class DescriptionReview extends StatefulWidget {
  final Product product;

  DescriptionReview({required this.product});

  @override
  _DescriptionReviewState createState() => _DescriptionReviewState();
}

class _DescriptionReviewState extends State<DescriptionReview> {
  bool isDescriptionExpanded = false;
  bool isReviewsExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ),
          SizedBox(height: 10), // Reduced space between sections
          _buildExpandableSection(
            title: 'Reviews',
            isExpanded: isReviewsExpanded,
            onTap: () => setState(() => isReviewsExpanded = !isReviewsExpanded),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.product.reviews
                  .map((review) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "- $review",
                          style: TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                      ))
                  .toList(),
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
