import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PenarikanTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Products').snapshots(),
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

        List<DataRow> rows = snapshot.data!.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          String docId = doc.id; // Firestore document ID

          return DataRow(
            cells: [
              DataCell(Text(data['id_penarikan'] ?? '')),
              DataCell(Text(data['tanggal'] ?? '')),
              DataCell(Text(data['jumlah'] ?? '')),
              DataCell(Text(data['metode']?.toString() ?? '')),
              DataCell(Text(data['no_tujuan']?.toString() ?? '')),
              DataCell(
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                     ElevatedButton(
                        onPressed: () => _approveItem(context, docId),
                        child: Text('Status'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[700],
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          );
        }).toList();

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 16, // Increased column spacing for better readability
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            columns: [
              DataColumn(label: _buildHeaderText('ID Penarikan')),
              DataColumn(label: _buildHeaderText('Tanggal Penarikan')),
              DataColumn(label: _buildHeaderText('Jumlah')),
              DataColumn(label: _buildHeaderText('Metode')),
              DataColumn(label: _buildHeaderText('No.Tujuan')),
              DataColumn(label: _buildHeaderText('Status')),
            ],
            rows: rows,
          ),
        );
      },
    );
  }

  Widget _buildImageCell(String? imageUrl, String productName) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(4),
      ),
      child: CachedNetworkImage(
        imageUrl: imageUrl ?? '',
        fit: BoxFit.cover,
        placeholder: (context, url) => Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => _buildPlaceholder(productName),
      ),
    );
  }

  Widget _buildPlaceholder(String productName) {
    return Container(
      width: 80,
      height: 80,
      color: Colors.grey[300],
      child: Center(
        child: Text(
          productName.isNotEmpty ? productName[0].toUpperCase() : '?',
          style: TextStyle(
            color: Colors.grey[600],
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  void _approveItem(BuildContext context, String docId) async {
    try {
      await FirebaseFirestore.instance.collection('Products').doc(docId).update({
        'approved': true,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Success: Item approved'),
          backgroundColor: Colors.green[700],
        ),
      );
    } catch (e) {
      print('Error approving item: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to approve item'),
          backgroundColor: Colors.red[700],
        ),
      );
    }
  }

  void _cancelItem(BuildContext context, String docId) async {
    try {
      await FirebaseFirestore.instance.collection('Products').doc(docId).update({
        'approved': false,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Success: Item canceled'),
          backgroundColor: Colors.red[700],
        ),
      );
    } catch (e) {
      print('Error canceling item: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to cancel item'),
          backgroundColor: Colors.red[700],
        ),
      );
    }
  }
}
