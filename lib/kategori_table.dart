import 'dart:io'; 
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class KategoriTable extends StatefulWidget {
  @override
  _KategoriTableState createState() => _KategoriTableState();
}

class _KategoriTableState extends State<KategoriTable> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  String? _imageUrl;

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
                DataColumn(label: Text('Nama Kategori', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Gambar', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Aksi', style: TextStyle(fontWeight: FontWeight.bold))),
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
                      _buildImageCell(data['foto'], data['nm_kategori'] ?? ''),
                    ),
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: () => _showEditDialog(context, docId, data),
                            child: Text('Edit'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[700],
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            ),
                          ),
                          SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () => _showDeleteConfirmationDialog(context, docId),
                            child: Text('Hapus'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[700],
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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

 Widget _buildImageCell(String? imageUrl, String nm_kategori) {
  if (imageUrl == null || imageUrl.isEmpty) {
    return _buildPlaceholder(nm_kategori);
  }
  
  return Container(
    width: 90,
    height: 90,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey[300]!),
      borderRadius: BorderRadius.circular(4),
    ),
    child: CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) {
        print('Failed to load image: $url, Error: $error');
        return _buildPlaceholder(nm_kategori);
      },
    ),
  );
}

  Widget _buildPlaceholder(String nm_kategori) {
    return Container(
      width: 80,
      height: 80,
      color: Colors.grey[300],
      child: Center(
        child: Text(
          nm_kategori.isNotEmpty ? nm_kategori[0].toUpperCase() : '?',
          style: TextStyle(
            color: Colors.grey[600],
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
    );
  }


  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadImage(File image) async {
    try {
      final storageRef = FirebaseStorage.instance.ref().child('category_images/${DateTime.now().toIso8601String()}');
      final uploadTask = storageRef.putFile(image);
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  void _showEditDialog(BuildContext context, String docId, Map<String, dynamic> data) {
    final TextEditingController nameController = TextEditingController(text: data['nm_kategori'] ?? '');
    final TextEditingController imageUrlController = TextEditingController(text: data['imageUrl'] ?? '');

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
              TextField(
                controller: imageUrlController,
                decoration: InputDecoration(labelText: 'URL Gambar'),
                readOnly: true,
                onTap: _pickImage, // Menambahkan fungsi untuk memilih gambar
              ),
              if (_selectedImage != null)
                Image.file(
                  _selectedImage!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
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
              onPressed: () async {
                String imageUrl = imageUrlController.text;
                if (_selectedImage != null) {
                  final uploadedImageUrl = await _uploadImage(_selectedImage!);
                  if (uploadedImageUrl != null) {
                    imageUrl = uploadedImageUrl;
                  }
                }
                _updateItem(context, docId, nameController.text, imageUrl);
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

  void _updateItem(BuildContext context, String docId, String name, String imageUrl) async {
    try {
      await FirebaseFirestore.instance.collection('category').doc(docId).update({
        'nm_kategori': name,
        'foto': imageUrl,
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

  void _showDeleteConfirmationDialog(BuildContext context, String docId) {
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
      await FirebaseFirestore.instance.collection('category').doc(docId).delete();
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