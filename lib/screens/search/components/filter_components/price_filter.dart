import 'package:flutter/material.dart';

class PriceFilter extends StatefulWidget {
   final Function(double, double) onpriceSelected;                        //######1

  PriceFilter({required this.onpriceSelected});                            //######2
  @override
  State<PriceFilter> createState() => _PriceFilterState();
}

class _PriceFilterState extends State<PriceFilter> {
  RangeValues _currentRange = RangeValues(10, 80);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RangeSlider(
          //price slider with RangeSlider
          values: _currentRange, // 👈 current range
          min: 0,
          max: 200,
          divisions: 10,
          activeColor: Colors.black, // filled part
          inactiveColor: Color(0xFFF3F3F6), // unfilled part
          labels: RangeLabels(
            '\$${_currentRange.start.round()}',
            '\$${_currentRange.end.round()}',
          ),
          onChanged: (RangeValues newRange) {
            setState(() {
              _currentRange = newRange;
            });
            widget.onpriceSelected(_currentRange.start, _currentRange.end);      //#####3
          },
        ),
        Row(
          //Show the selected prices below
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('\$${_currentRange.start.round()}'),
            Text('\$${_currentRange.end.round()}'),
          ],
        )
      ],
    );
  }
}
