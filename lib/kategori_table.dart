import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class KategoriTable extends StatefulWidget {
  @override
  _KategoriTableState createState() => _KategoriTableState();
}

class _KategoriTableState extends State<KategoriTable> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('category').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Terjadi kesalahan saat memuat data.'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('Tidak ada data kategori.'));
        }

        final kategoriDocs = snapshot.data!.docs;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            padding: EdgeInsets.all(16),
            child: DataTable(
              columnSpacing: 150,
              columns: const [
                DataColumn(
                    label: Text('Nama Kategori',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Aksi',
                        style: TextStyle(fontWeight: FontWeight.bold))),
              ],
              rows: kategoriDocs.map((doc) {
                final data = doc.data() as Map<String, dynamic>;
                final docId = doc.id;
                return DataRow(
                  cells: [
                    DataCell(
                      Container(
                        width: 200,
                        child: Text(data['nm_kategori'] ?? ''),
                      ),
                    ),
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: () =>
                                _showEditDialog(context, docId, data),
                            child: Text('Edit'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[700],
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                            ),
                          ),
                          SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () =>
                                _showDeleteConfirmationDialog(context, docId),
                            child: Text('Hapus'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[700],
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, String docId,
      Map<String, dynamic> data) {
    final TextEditingController nameController =
        TextEditingController(text: data['nm_kategori'] ?? '');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Kategori'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Nama Kategori'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                _updateItem(context, docId, nameController.text);
                Navigator.of(context).pop();
              },
              child: Text('Simpan'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
                foregroundColor: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }

  void _updateItem(
      BuildContext context, String docId, String name) async {
    try {
      await FirebaseFirestore.instance
          .collection('category')
          .doc(docId)
          .update({
        'nm_kategori': name,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Item berhasil diperbarui'),
          backgroundColor: Colors.green[700],
        ),
      );
    } catch (e) {
      print('Error updating item: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal memperbarui item'),
          backgroundColor: Colors.red[700],
        ),
      );
    }
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, String docId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Hapus'),
          content: Text('Apakah Anda yakin ingin menghapus item ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                _deleteItem(context, docId);
                Navigator.of(context).pop();
              },
              child: Text('Hapus'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[700],
                foregroundColor: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }

  void _deleteItem(BuildContext context, String docId) async {
    try {
      await FirebaseFirestore.instance
          .collection('category')
          .doc(docId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Item berhasil dihapus'),
          backgroundColor: Colors.red[700],
        ),
      );
    } catch (e) {
      print('Error deleting item: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menghapus item'),
          backgroundColor: Colors.red[700],
        ),
      );
    }
  }
}
