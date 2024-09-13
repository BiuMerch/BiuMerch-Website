<<<<<<< HEAD
import 'package:apa/Toko_page.dart';
import 'package:apa/kategori_page.dart';
import 'package:apa/user.dart';
import 'package:flutter/material.dart';
import 'package:apa/login_page.dart';
import 'package:apa/produk_page.dart';
import 'package:apa/pemesanan.dart';
import 'package:apa/penarikan_table.dart';
import 'package:apa/banner_page.dart';
import 'package:apa/Admin_page.dart';
import 'package:apa/penarikan_form.dart';
import 'product_table.dart'; // Make sure this file exists with the ProductTable widget
=======
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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:apa/user.dart'; 
>>>>>>> 3d0ddc8 (Pembaruan Web)

class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

<<<<<<< HEAD
class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Pilih metode penarikan',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              content: FormWidget(),
              actions: <Widget>[
                TextButton(
                  child: Text('Tutup'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      child: Text('Tarik Saldo'),
    );
  }
}

=======
>>>>>>> 3d0ddc8 (Pembaruan Web)
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
<<<<<<< HEAD
          Row(
=======
            Row(
>>>>>>> 3d0ddc8 (Pembaruan Web)
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
<<<<<<< HEAD

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
=======
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
>>>>>>> 3d0ddc8 (Pembaruan Web)
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
<<<<<<< HEAD
                      'kategori',
=======
                      'Kategori',
>>>>>>> 3d0ddc8 (Pembaruan Web)
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
<<<<<<< HEAD

=======
>>>>>>> 3d0ddc8 (Pembaruan Web)
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
<<<<<<< HEAD

=======
>>>>>>> 3d0ddc8 (Pembaruan Web)
                    _buildMenuItem(
                      context,
                      Icons.shopping_cart,
                      'Toko',
                      () {
<<<<<<< HEAD
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TokoPage()),
                        ).then((_) {
                          setState(() {
                            _selectedMenu = 'Toko';
                          });
=======
                        setState(() {
                          _selectedMenu = 'Toko';
>>>>>>> 3d0ddc8 (Pembaruan Web)
                        });
                      },
                      _selectedMenu == 'Toko',
                    ),
                    _buildDivider(),
<<<<<<< HEAD

=======
>>>>>>> 3d0ddc8 (Pembaruan Web)
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
<<<<<<< HEAD
                    Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.exit_to_app, color: Colors.white),
                              SizedBox(width: 8),
                              Text('Keluar',
                                  style: TextStyle(color: Colors.white)),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF0B4D3B),
                            foregroundColor: Colors.white,
                            minimumSize: Size(double.infinity, 40),
                            side: BorderSide(color: Color(0xFF0B4D3B)),
                          ),
                        ),
                      ),
                    ),
                  ),
=======
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
>>>>>>> 3d0ddc8 (Pembaruan Web)
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
<<<<<<< HEAD
                        'Penarikan',
=======
                        'Toko',
>>>>>>> 3d0ddc8 (Pembaruan Web)
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
<<<<<<< HEAD
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(color: Colors.black),
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromARGB(50, 0, 0, 0)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Column(
                                  children: [
                                    Text(
                                      "Saldo anda :",
                                      textAlign: TextAlign.start,
                                    ),
                                    Text(
                                      "Rp.1000.000",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.green),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    MyButton()
                                  ],
                                ),
                              )),
                          SizedBox(height: 20),
                          Text(
                            "History penarikan ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Divider(color: Colors.black),
                          SizedBox(height: 20),
                          PenarikanTable()
                        ],
                      )),
=======
                      SizedBox(height: 16),
                      Expanded(
                        child: WithdrawlTable(), 
                      ),
>>>>>>> 3d0ddc8 (Pembaruan Web)
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
<<<<<<< HEAD
                _selectedMenu = title;
=======
                // Update the selected menu item
>>>>>>> 3d0ddc8 (Pembaruan Web)
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
<<<<<<< HEAD
=======



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

          String atasNama = data['atas_nama'] ?? 'N/A';
          int jumlahPenarikan = data['jumlah_penarikan'] ?? 0;
          String namaBankEwalet = data['nama_bank/ewalet'] ?? 'N/A';
          String nomorRekening = data['nomor_rekening'] ?? 'N/A';
          String status = data['status'] ?? 'Pending';
          String tanggal = data['tanggal'] ?? 'N/A';
          String buktiBayar = data['buktiBayar'] ?? 'No proof uploaded';

          return DataRow(
            cells: [
              DataCell(Text((index + 1).toString())),
              DataCell(Text(atasNama)),
              DataCell(Text('Rp.${jumlahPenarikan.toString()}')),
              DataCell(Text(namaBankEwalet)),
              DataCell(Text(nomorRekening)),
              DataCell(Text(status)),
              DataCell(Text(tanggal)),
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
                DataColumn(label: _buildHeaderText('Atas Nama')),
                DataColumn(label: _buildHeaderText('Jumlah Penarikan')),
                DataColumn(label: _buildHeaderText('Nama Bank/E-Wallet')),
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

  Widget _buildHeaderText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
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

  void _uploadPaymentProof(BuildContext context, String docId) async {
    // Use file_picker for cross-platform compatibility
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
>>>>>>> 3d0ddc8 (Pembaruan Web)
