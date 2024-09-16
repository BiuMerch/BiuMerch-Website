import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No products available'));
        }

        List<DataRow> rows = snapshot.data!.docs.asMap().entries.map((entry) {
          int index = entry.key;
          QueryDocumentSnapshot doc = entry.value;
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

          // Extract data from Firestore document
          String name = data['name'] ?? 'No Name';
          String price = data['price'] ?? '0';
          String stock = data['stock'] ?? '0';
          String rating = data['rating'] ?? '0';
          String description = data['description'] ?? 'No Description';

          return DataRow(
            cells: [
              DataCell(Text('${index + 1}')), // Serial number
              DataCell(Text(name)),
              DataCell(Text(price)),
              DataCell(Text(stock)),
              DataCell(Text(rating)),
              DataCell(Text(description)),
              DataCell(
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _confirmDelete(context, doc.id),
                ),
              ),
            ],
          );
        }).toList();

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
              columnSpacing: 16, // Column spacing for better readability
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              columns: [
                DataColumn(
                    label: _buildHeaderText('No')), // Serial number header
                DataColumn(label: _buildHeaderText('Name')),
                DataColumn(label: _buildHeaderText('Price')),
                DataColumn(label: _buildHeaderText('Stock')),
                DataColumn(label: _buildHeaderText('Rating')),
                DataColumn(label: _buildHeaderText('Description')),
                DataColumn(label: _buildHeaderText('Action')), // Action header
              ],
              rows: rows,
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeaderText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Nunito',
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  void _confirmDelete(BuildContext context, String productId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text(
              'Are you sure you want to delete this product? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _deleteProduct(productId, context); // Proceed with deletion
              },
              child: Text('Delete'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Red button for delete action
              ),
            ),
          ],
        );
      },
    );
  }

  void _deleteProduct(String productId, BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete product: $e')),
      );
    }
  }
}
