import 'package:flutter/material.dart';

class PriceFilter extends StatefulWidget {
   final Function(double, double) onpriceSelected;                 

  PriceFilter({required this.onpriceSelected});             
  @override
  State<PriceFilter> createState() => _PriceFilterState();
}

class _PriceFilterState extends State<PriceFilter> {
  RangeValues _currentRange = RangeValues(0, 200);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RangeSlider(
          //price slider with RangeSlider
          values: _currentRange, //current range
          min: 0,
          max: 200,
          divisions: 20,
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
            widget.onpriceSelected(_currentRange.start, _currentRange.end);
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
