import 'package:flutter/material.dart';

class FilterSidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(20),
        children: [
          // Header of the drawer (optional)
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Filters',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          // Price filter
          Text('Price'),
          Slider(
            value: 50,
            min: 0,
            max: 100,
            onChanged: (value) {},
          ),
          SizedBox(height: 20),
          // Color filter
          Text('Color'),
          DropdownButton<String>(
            value: 'Red',
            onChanged: (String? newValue) {},
            items: <String>['Red', 'Blue', 'Green']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          // Rating filter
          Text('Rating'),
          Row(
            children: List.generate(5, (index) {
              return Icon(
                Icons.star,
                color: index < 4 ? Colors.yellow : Colors.grey,
              );
            }),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Apply filters logic
              Navigator.pop(context); // Close the drawer
            },
            child: Text('Apply Filters'),
          ),
        ],
      ),
    );
  }
}
