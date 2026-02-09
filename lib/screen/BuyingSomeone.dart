
import 'package:flutter/material.dart';


class BuyingSomethingScreen extends StatefulWidget {
  @override
  _BuyingSomethingScreenState createState() => _BuyingSomethingScreenState();
}

class _BuyingSomethingScreenState extends State<BuyingSomethingScreen> {
  List<String> items = [
    'A box of instant noodles',
    '3 box of coffee',
  ];

  void _addItem() {
    setState(() {
      items.add('New item');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buying Something'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Icon
            Row(
              children: [
                Icon(
                  Icons.shopping_cart,
                  color: Colors.green,
                ),
                SizedBox(width: 8),
                Text(
                  'Monthly Needs',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Checkboxes
            ...items.map((item) => CheckboxListTile(
              value: false,
              onChanged: (bool? value) {},
              title: Text(item),
            )).toList(),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: _addItem,
                child: Row(
                  children: [
                    Icon(Icons.add, color: Colors.purple),
                    SizedBox(width: 8),
                    Text(
                      'Add checkbox',
                      style: TextStyle(color: Colors.purple),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Reminder section
            Text(
              'Reminder set on 15/07/2021, 18:30',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),

            // Tags section
            Wrap(
              spacing: 8.0, // gap between tags
              runSpacing: 4.0, // gap between rows
              children: [
                _TagChip(label: 'Important'),
                _TagChip(label: 'Top Priority'),
                _TagChip(label: 'Should be Done This Week'),
              ],
            ),
            SizedBox(height: 20),

            // Last edited text
            Text(
              'Last edited on 19.30',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 20),

            // Footer buttons (Search and Menu)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.more_horiz),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  final String label;

  const _TagChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.green,
    );
  }
}