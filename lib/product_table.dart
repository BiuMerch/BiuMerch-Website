import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
<<<<<<< HEAD
import 'package:cached_network_image/cached_network_image.dart';
=======
>>>>>>> 3d0ddc8 (Pembaruan Web)

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
<<<<<<< HEAD
          String storeId = data['storeId'] ?? 'N/A';
          String name = data['name'] ?? 'No Name';
          String category = data['category'] ?? 'Uncategorized';
=======
          String name = data['name'] ?? 'No Name';
>>>>>>> 3d0ddc8 (Pembaruan Web)
          String price = data['price'] ?? '0';
          String stock = data['stock'] ?? '0';
          String rating = data['rating'] ?? '0';
          String description = data['description'] ?? 'No Description';
<<<<<<< HEAD
          List<dynamic>? imageUrls = data['imageUrls'] as List<dynamic>?;
=======
>>>>>>> 3d0ddc8 (Pembaruan Web)

          return DataRow(
            cells: [
              DataCell(Text('${index + 1}')), // Serial number
<<<<<<< HEAD
              DataCell(Text(storeId)),
              DataCell(Text(name)),
              DataCell(Text(category)),
              DataCell(Text(price)),
              DataCell(Text(stock)),
              DataCell(Text(rating)),
              DataCell(_buildImageCell(imageUrls, name, context)),
=======
              DataCell(Text(name)),
              DataCell(Text(price)),
              DataCell(Text(stock)),
              DataCell(Text(rating)),
>>>>>>> 3d0ddc8 (Pembaruan Web)
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
<<<<<<< HEAD
                DataColumn(
                    label: _buildHeaderText('No')), // Serial number header
                DataColumn(label: _buildHeaderText('Store ID')),
                DataColumn(label: _buildHeaderText('Name')),
                DataColumn(label: _buildHeaderText('Category')),
                DataColumn(label: _buildHeaderText('Price')),
                DataColumn(label: _buildHeaderText('Stock')),
                DataColumn(label: _buildHeaderText('Rating')),
                DataColumn(label: _buildHeaderText('Image')),
=======
                DataColumn(label: _buildHeaderText('No')), // Serial number header
                DataColumn(label: _buildHeaderText('Name')),
                DataColumn(label: _buildHeaderText('Price')),
                DataColumn(label: _buildHeaderText('Stock')),
                DataColumn(label: _buildHeaderText('Rating')),
>>>>>>> 3d0ddc8 (Pembaruan Web)
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

<<<<<<< HEAD
  Widget _buildImageCell(
      List<dynamic>? imageUrls, String productName, BuildContext context) {
    if (imageUrls == null || imageUrls.isEmpty) {
      return _buildPlaceholder('No Image');
    }

    // Display the first image, but tap to view all images
    String firstImageUrl = imageUrls[0] as String;

    return GestureDetector(
      onTap: () => _showImageDialog(context, imageUrls, productName),
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(4),
        ),
        child: CachedNetworkImage(
          imageUrl: firstImageUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => _buildPlaceholder('Error'),
        ),
      ),
    );
  }

  Widget _buildPlaceholder(String text) {
    return Container(
      width: 80,
      height: 80,
      color: Colors.grey[300],
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.grey[600],
            fontFamily: 'Nunito',
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
    );
  }

=======
>>>>>>> 3d0ddc8 (Pembaruan Web)
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

<<<<<<< HEAD
  void _showImageDialog(
      BuildContext context, List<dynamic> imageUrls, String productName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: PageView(
                    children: imageUrls.map((url) {
                      return CachedNetworkImage(
                        imageUrl: url as String,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            _buildPlaceholder('Error'),
                        fit: BoxFit.contain,
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  productName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text("Tutup"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Background color
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

=======
>>>>>>> 3d0ddc8 (Pembaruan Web)
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
