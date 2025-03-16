import 'package:flutter/material.dart';

class ProductPrice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 39,
      left: 23,
      child: Container(
        width: 311,
        height: 45,
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Color.fromRGBO(232, 232, 232, 1))),
          
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Product price',
              style: TextStyle(
                color: Color.fromRGBO(0, 0, 0, 1),
                fontFamily: 'Product Sans Medium',
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              '\$110',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Product Sans Medium',
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
