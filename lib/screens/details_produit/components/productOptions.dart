import 'package:flutter/material.dart';

class ProductOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
      child: Container(
        width: 500,
        height: 65,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Color',
                  style: TextStyle(
                    color: Color(0xFF777E90),
                    fontSize: 14,
                    fontFamily: 'Product Sans Medium',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'Size',
                  style: TextStyle(
                    color: Color(0xFF777E90),
                    fontSize: 14,
                    fontFamily: 'Product Sans Medium',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(
                  spacing: 8,
                  children: [
                    colorOption(Colors.white, Colors.brown),
                    colorOption(Colors.black),
                    colorOption(Colors.red),
                  ],
                ),
                Wrap(
                  spacing: 8,
                  children: [
                    sizeOption('S', Colors.grey),
                    sizeOption('M', Colors.grey),
                    sizeOption('L', Colors.black, Colors.white),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget colorOption(Color borderColor, [Color? innerColor]) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: borderColor,
        boxShadow: [
          BoxShadow(
            color: Color(0x21000000),
            blurRadius: 8,
            offset: Offset(-1, 5),
          ),
        ],
      ),
      child: innerColor != null
          ? Center(
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: innerColor,
                  shape: BoxShape.circle,
                ),
              ),
            )
          : null,
    );
  }

  Widget sizeOption(String label, Color bgColor,
      [Color textColor = Colors.black]) {
    return Container(
      width: 33,
      height: 33,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16.5),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
