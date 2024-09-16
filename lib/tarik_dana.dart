import 'dart:io';

import 'package:apa/Admin_page.dart';
import 'package:apa/Toko_page.dart';
import 'package:apa/banner_page.dart';
import 'package:apa/kategori_page.dart';
import 'package:apa/pemesanan.dart';
import 'package:apa/produk_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:apa/login_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:apa/user.dart'; 

class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  String _selectedMenu = 'Tarik Dana';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/background.png',
              fit: BoxFit.cover,
            ),
          ),
            Row(
            children: [
              // Sidebar
              Container(
                width: 250,
                color: Colors.grey[200],
                child: Column(
                  children: [
                    // Logo
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.asset('assets/logo.png'),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'BIU Merch',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green[700],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    _buildDivider(),
                    // Menu items
                    _buildMenuItem(
                      context,
                      Icons.dashboard,
                      'Dashboard',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AdminPage()),
                        ).then((_) {
                          setState(() {
                            _selectedMenu = 'Dashboard';
                          });
                        });
                      },
                      _selectedMenu == 'Dashboard',
                    ),
                    _buildDivider(),
                    _buildMenuItem(
                      context,
                      Icons.supervised_user_circle,
                      'User',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UserPage()),
                        ).then((_) {
                          setState(() {
                            _selectedMenu = 'user';
                          });
                        });
                      },
                      _selectedMenu == 'user',
                    ),
                    _buildDivider(),
                     _buildMenuItem(
                      context,
                      Icons.monetization_on,
                      'Tarik Dana',
                      () {
                        setState(() {
                          _selectedMenu = 'Tarik Dana';
                        });
                      },
                      _selectedMenu == 'Tarik Dana',
                    ),
                    _buildDivider(),
                    _buildMenuItem(
                      context,
                      Icons.inventory,
                      'Produk',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProdukPage()),
                        ).then((_) {
                          setState(() {
                            _selectedMenu = 'Produk';
                          });
                        });
                      },
                      _selectedMenu == 'Produk',
                    ),
                    _buildDivider(),
                    _buildMenuItem(
                      context,
                      Icons.category,
                      'Kategori',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => KategoriPage()),
                        ).then((_) {
                          setState(() {
                            _selectedMenu = 'Kategori';
                          });
                        });
                      },
                      _selectedMenu == 'Kategori',
                    ),
                    _buildDivider(),
                    _buildMenuItem(
                      context,
                      Icons.payment,
                      'Transaksi',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PemesananPage()),
                        ).then((_) {
                          setState(() {
                            _selectedMenu = 'Transaksi';
                          });
                        });
                      },
                      _selectedMenu == 'Transaksi',
                    ),
                    _buildDivider(),
                    _buildMenuItem(
                      context,
                      Icons.shopping_cart,
                      'Toko',
                      () {
                        setState(() {
                          _selectedMenu = 'Toko';
                        });
                      },
                      _selectedMenu == 'Toko',
                    ),
                    _buildDivider(),
                    _buildMenuItem(
                      context,
                      Icons.flag,
                      'Banner',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BannerPage()),
                        ).then((_) {
                          setState(() {
                            _selectedMenu = 'Banner';
                          });
                        });
                      },
                      _selectedMenu == 'Banner',
                    ),
                    _buildDivider(),
                    ElevatedButton(
                      onPressed: () async {
                        // Clear the session
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.clear(); // Clear all stored preferences

                        // Navigate back to login page
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.exit_to_app, color: Colors.white),
                          SizedBox(width: 8),
                          Text('Keluar', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0B4D3B),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 40),
                        side: const BorderSide(color: Color(0xFF0B4D3B)),
                      ),
                    )
                  ],
                ),
              ),
              // Main content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selamat Datang Di Halaman Admin BIU Merch',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700],
                        ),
                      ),
                      SizedBox(height: 24),
                      Text(
                        'Toko',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Expanded(
                        child: WithdrawlTable(), 
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.grey,
      thickness: 1,
      indent: 16,
      endIndent: 16,
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
    bool isSelected,
  ) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isHovering = false;

        return MouseRegion(
          onEnter: (_) => setState(() => isHovering = true),
          onExit: (_) => setState(() => isHovering = false),
          child: GestureDetector(
            onTap: () {
              onTap();
              setState(() {
                // Update the selected menu item
              });
            },
            child: Container(
              color: isSelected || isHovering
                  ? Colors.grey[300]
                  : Colors.transparent,
              child: ListTile(
                leading: Icon(
                  icon,
                  color: isSelected || isHovering
                      ? Colors.green[700]
                      : Colors.black,
                ),
                title: Text(
                  title,
                  style: TextStyle(
                    color: isSelected || isHovering
                        ? Colors.green[700]
                        : Colors.black,
                    fontWeight: isSelected || isHovering
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}



class WithdrawlTable extends StatelessWidget {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('withdrawl').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No withdrawl records available'));
        }

        List<DataRow> rows = snapshot.data!.docs.asMap().entries.map((entry) {
          int index = entry.key;
          var doc = entry.value;

          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          String docId = doc.id;

          // Menggunakan field-field baru
          String idStore = data['idstore'] ?? 'N/A';
          int nominal = data['nominal'] ?? 0;
          String namaPenerima = data['nama_penerima'] ?? 'N/A';
          String provider = data['provider'] ?? 'N/A';
          String nomorRekening = data['nomor_rekening'] ?? 'N/A';
          String status = data['status'] ?? 'Pending';
          String tanggal = data['tanggal'] ?? 'N/A';
          String buktiBayar = data['buktiBayar'] ?? 'No proof uploaded';

          // Parsing tanggal to DateTime and formatting
          DateTime parsedTanggal = DateTime.tryParse(tanggal) ?? DateTime.now();
          String formattedTanggal = DateFormat('yyyy-MM-dd HH:mm:ss').format(parsedTanggal);

          return DataRow(
            cells: [
              DataCell(Text((index + 1).toString())),
              DataCell(Text(idStore)),
              DataCell(Text('Rp.${nominal.toString()}')),
              DataCell(Text(namaPenerima)),
              DataCell(Text(provider)),
              DataCell(Text(nomorRekening)),
              DataCell(Text(status)),
              DataCell(Text(formattedTanggal)),
              DataCell(
                buktiBayar != 'No proof uploaded'
                    ? GestureDetector(
                        onTap: () {
                          _showProofImage(context, buktiBayar);
                        },
                        child: Text(
                          'View Proof',
                          style: TextStyle(color: Colors.blue),
                        ),
                      )
                    : Text(buktiBayar),
              ),
              DataCell(
                Row(
                  children: [
                    // Done Button
                    ElevatedButton(
                      onPressed: status == 'Done'
                          ? null // Disable if status is 'Done'
                          : () => _updateWithdrawlStatus(context, docId, 'Done'),
                      child: Text('Done'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: status == 'Done'
                            ? Colors.grey // Grey when disabled
                            : Colors.green, // Green when enabled
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      ),
                    ),
                    SizedBox(width: 8),
                    // Cancel Button
                    ElevatedButton(
                      onPressed: status == 'Cancel'
                          ? null // Disable if status is 'Cancel'
                          : () => _updateWithdrawlStatus(context, docId, 'Cancel'),
                      child: Text('Cancel'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: status == 'Cancel'
                            ? Colors.grey // Grey when disabled
                            : Colors.orange, // Orange when enabled
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      ),
                    ),
                    SizedBox(width: 8),
                    // Delete Button (Always enabled)
                    ElevatedButton(
                      onPressed: () => _confirmDeleteWithdrawl(context, docId),
                      child: Text('Delete'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      ),
                    ),
                    SizedBox(width: 8),
                    // Upload Proof Button (Always enabled)
                    ElevatedButton(
                      onPressed: () => _uploadPaymentProof(context, docId),
                      child: Text('Upload Proof'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
              columnSpacing: 16,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              columns: [
                DataColumn(label: _buildHeaderText('No')),
                DataColumn(label: _buildHeaderText('ID Store')),
                DataColumn(label: _buildHeaderText('Nominal')),
                DataColumn(label: _buildHeaderText('Nama Penerima')),
                DataColumn(label: _buildHeaderText('Provider')),
                DataColumn(label: _buildHeaderText('Nomor Rekening')),
                DataColumn(label: _buildHeaderText('Status')),
                DataColumn(label: _buildHeaderText('Tanggal')),
                DataColumn(label: _buildHeaderText('Bukti Bayar')),
                DataColumn(label: _buildHeaderText('Actions')),
              ],
              rows: rows,
            ),
          ),
        );
      },
    );
  }

  void _updateWithdrawlStatus(BuildContext context, String docId, String status) {
    FirebaseFirestore.instance.collection('withdrawl').doc(docId).update({
      'status': status,
    }).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Status updated to $status')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update status: $error')),
      );
    });
  }

  Widget _buildHeaderText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  void _uploadPaymentProof(BuildContext context, String docId) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      PlatformFile pickedFile = result.files.first;

      try {
        UploadTask uploadTask;

        if (kIsWeb) {
          // For web, upload the selected file bytes
          uploadTask = _storage
              .ref('payment_proofs/${docId}_${DateTime.now().millisecondsSinceEpoch}.png')
              .putData(pickedFile.bytes!);
        } else {
          // For mobile, upload the file path
          File file = File(pickedFile.path!);
          uploadTask = _storage
              .ref('payment_proofs/${docId}_${DateTime.now().millisecondsSinceEpoch}.png')
              .putFile(file);
        }

        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();

        // Save the URL in Firestore
        await FirebaseFirestore.instance.collection('withdrawl').doc(docId).update({
          'buktiBayar': downloadUrl,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bukti bayar uploaded successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload bukti bayar: $e')),
        );
      }
    }
  }

  void _showProofImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Image.network(imageUrl),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteWithdrawl(BuildContext context, String docId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Deletion'),
        content: Text('Are you sure you want to delete this withdrawl record?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              FirebaseFirestore.instance.collection('withdrawl').doc(docId).delete();
              Navigator.of(context).pop();
            },
            child: Text('Delete'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

