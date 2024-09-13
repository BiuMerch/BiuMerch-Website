import 'package:apa/Toko_page.dart';
import 'package:apa/kategori_page.dart';
import 'package:apa/pesanan_table.dart';
import 'package:apa/tarik_dana.dart';
import 'package:apa/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:apa/login_page.dart';
import 'package:apa/produk_page.dart';
import 'package:apa/penarikan_table.dart';
import 'package:apa/banner_page.dart';
import 'package:apa/Admin_page.dart';
import 'package:apa/penarikan_form.dart';
<<<<<<< HEAD
=======
import 'package:shared_preferences/shared_preferences.dart';
>>>>>>> 3d0ddc8 (Pembaruan Web)

class PemesananPage extends StatefulWidget {
  @override
  _PemesananPageState createState() => _PemesananPageState();
}

class _PemesananPageState extends State<PemesananPage> {
  String _selectedMenu = 'Transaksi';

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
              color: Colors.grey[200]!.withOpacity(0.9), // Slightly transparent sidebar
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
                          _selectedMenu = 'User';
                        });
                      });
                    },
                    _selectedMenu == 'User',
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    context,
                    Icons.monetization_on,
                    'Tarik Dana',
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WalletPage()),
                      ).then((_) {
                        setState(() {
                          _selectedMenu = 'Tarik Dana';
                        });
                      });
                    },
                    _selectedMenu == 'Tarik Dana',
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    context,
                    Icons.category,
                    'Produk',
                    () {
                      setState(() {
                        _selectedMenu = 'Produk';
                      });
                    },
                    _selectedMenu == 'Produk',
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    context,
                    Icons.inventory,
                    'Kategori',
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => KategoriPage()),
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
                        setState(() {
                          _selectedMenu = 'Transaksi';
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TokoPage()),
                      ).then((_) {
                        setState(() {
                          _selectedMenu = 'Toko';
                        });
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
                child: SingleChildScrollView(
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
                          'Transaksi',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 24),
                        _buildStatusBoxes(),
                        SizedBox(height: 20),
                        Text(
                          "Daftar Transaksi",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Divider(color: Colors.black),
                        SizedBox(height: 20),
                        PesananTable(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBoxes() {
    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance.collectionGroup('transaksi').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No transactions available'));
        }

        int pendingCount = 0;
        int completedCount = 0;
        int canceledCount = 0;
        int processCount = 0;

        for (var doc in snapshot.data!.docs) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          String status = (data['status'] ?? 'N/A').toLowerCase();

          if (status == 'pending') {
            pendingCount++;
          } else if (status == 'completed') {
            completedCount++;
          } else if (status == 'cancel') {
            canceledCount++;
          } else if (status == 'process') {
            processCount++;
          }
        }

        return Row(
          children: [
            _buildStatusBox('Menunggu Konfirmasi', pendingCount, Color(0xFF62E703)),
            SizedBox(width: 10),
            _buildStatusBox('Transaksi Di Proses', processCount, Color(0xFF62E703)),
            SizedBox(width: 10),
            _buildStatusBox('Transaksi Gagal', canceledCount, Color(0xFF62E703)),
            SizedBox(width: 10),
            _buildStatusBox('Transaksi Selesai', completedCount, Color(0xFF62E703)),
          ],
        );
      },
    );
  }

  Widget _buildStatusBox(String label, int count, Color color) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Text(
                "$label:",
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 5),
              Text(
                "$count",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ),
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
                _selectedMenu = title;
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



 Widget _buildDivider() {
    return Divider(
      color: Colors.grey,
      thickness: 1,
      indent: 16,
      endIndent: 16,
    );
  }
}
class PesananTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance.collectionGroup('transaksi').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No transactions available'));
        }

        List<DataRow> rows = [];
        int rowNumber = 1;

        for (var doc in snapshot.data!.docs) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          String docId = doc.id;

          String customerName = data['customerName'] ?? 'N/A';
          String customerPhone = data['customerPhone'] ?? 'N/A';
          String status = data['status'] ?? 'N/A';
          Timestamp expiryTime =
              data['expiryTime'] as Timestamp? ?? Timestamp.now();
<<<<<<< HEAD
          String qrisUrl = data['qrisUrl'] ?? 'N/A';
=======
>>>>>>> 3d0ddc8 (Pembaruan Web)
          int totalPrice = data['totalPrice'] ?? 0;

          List<dynamic> stores = data['stores'] ?? [];
          List<dynamic> items = [];
          String catatanTambahan = '';
          String storeName = '';

          if (stores.isNotEmpty) {
            Map<String, dynamic> firstStore = stores[0];
            items = firstStore['items'] ?? [];
            catatanTambahan = firstStore['catatanTambahan'] ?? '';
            storeName = firstStore['storeName'] ?? 'N/A';
          }

          if (items.isNotEmpty) {
            Map<String, dynamic> firstItem = items[0];
<<<<<<< HEAD
            String productImage = firstItem['productImage'] ?? '';
=======
>>>>>>> 3d0ddc8 (Pembaruan Web)
            String productName = firstItem['productName'] ?? 'N/A';
            int productPrice = firstItem['productPrice'] ?? 0;
            int quantity = firstItem['quantity'] ?? 0;
            Timestamp timestamp =
                firstItem['timestamp'] as Timestamp? ?? Timestamp.now();

            rows.add(DataRow(
              cells: [
                DataCell(Text(rowNumber.toString())),
                DataCell(Text(customerName)),
                DataCell(Text(customerPhone)),
<<<<<<< HEAD
                DataCell(_buildImageCell(context, productImage, productName)),
=======
>>>>>>> 3d0ddc8 (Pembaruan Web)
                DataCell(Text(productName)),
                DataCell(Text(productPrice.toString())),
                DataCell(Text(quantity.toString())),
                DataCell(Text(status)),
                DataCell(Text(timestamp.toDate().toString())),
<<<<<<< HEAD
                DataCell(
                    Text(totalPrice.toString())), // Gunakan totalPrice di sini
=======
                DataCell(Text(totalPrice.toString())),
>>>>>>> 3d0ddc8 (Pembaruan Web)
                DataCell(Text(storeName)),
                DataCell(Text(expiryTime.toDate().toString())),
                DataCell(
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (status.toLowerCase() == 'completed') ...[
                        Icon(Icons.check, color: Colors.green[700]),
                      ],
                      if (status.toLowerCase() == 'cancel') ...[
                        Icon(Icons.cancel, color: Colors.red[700]),
                      ],
                      if (status.toLowerCase() == 'pending') ...[
                        Icon(Icons.hourglass_empty, color: Colors.orange[700]),
                      ],
                      if (status.toLowerCase() == 'process') ...[
                        Icon(Icons.sync, color: Colors.blue[700]),
                      ],
                    ],
                  ),
                ),
              ],
            ));
          } else {
            rows.add(DataRow(
              cells: [
                DataCell(Text(rowNumber.toString())),
                DataCell(Text(customerName)),
                DataCell(Text(customerPhone)),
                DataCell(Text('N/A')),
<<<<<<< HEAD
                DataCell(Text('N/A')),
=======
>>>>>>> 3d0ddc8 (Pembaruan Web)
                DataCell(Text('0')),
                DataCell(Text('0')),
                DataCell(Text(status)),
                DataCell(Text(expiryTime.toDate().toString())),
<<<<<<< HEAD
                DataCell(
                    Text(totalPrice.toString())), // Gunakan totalPrice di sini
=======
                DataCell(Text(totalPrice.toString())),
>>>>>>> 3d0ddc8 (Pembaruan Web)
                DataCell(Text(storeName)),
                DataCell(Text(expiryTime.toDate().toString())),
                DataCell(
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (status == 'Completed') ...[
                        Icon(Icons.check, color: Colors.green[700]),
                      ],
                      if (status == 'cancel') ...[
                        Icon(Icons.cancel, color: Colors.red[700]),
                      ],
                      if (status == 'pending') ...[
                        Icon(Icons.hourglass_empty, color: Colors.orange[700]),
                      ],
                    ],
                  ),
                ),
              ],
            ));
          }
          rowNumber++;
        }

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
                DataColumn(label: _buildHeaderText('No.')),
                DataColumn(label: _buildHeaderText('Customer Name')),
                DataColumn(label: _buildHeaderText('Customer Phone')),
<<<<<<< HEAD
                DataColumn(label: _buildHeaderText('Product Image')),
=======
>>>>>>> 3d0ddc8 (Pembaruan Web)
                DataColumn(label: _buildHeaderText('Product Name')),
                DataColumn(label: _buildHeaderText('Product Price')),
                DataColumn(label: _buildHeaderText('Quantity')),
                DataColumn(label: _buildHeaderText('Status')),
                DataColumn(label: _buildHeaderText('Timestamp')),
                DataColumn(label: _buildHeaderText('Total Price')),
                DataColumn(label: _buildHeaderText('Store Name')),
                DataColumn(label: _buildHeaderText('Expiry Time')),
                DataColumn(label: _buildHeaderText('Actions')),
              ],
              rows: rows,
            ),
          ),
        );
      },
    );
  }

<<<<<<< HEAD


  Map<String, int> _processTransactions(List<QueryDocumentSnapshot> docs) {
    Map<String, int> monthlyTransactions = {};
    for (var doc in docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      Timestamp timestamp = data['timestamp'] as Timestamp? ?? Timestamp.now();
      DateTime date = timestamp.toDate();
      String monthYear = '${date.month}-${date.year}';
      
      monthlyTransactions[monthYear] = (monthlyTransactions[monthYear] ?? 0) + 1;
    }
    return monthlyTransactions;
  }
  Widget _buildImageCell(
      BuildContext context, String imageUrl, String productName) {
    return GestureDetector(
      onTap: () {
        _showImageDialog(context, imageUrl, productName);
      },
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(4),
        ),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => _buildPlaceholder(productName),
        ),
      ),
    );
  }

  void _showImageDialog(
      BuildContext context, String imageUrl, String productName) {
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
                CachedNetworkImage(
                  imageUrl: imageUrl,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      _buildPlaceholder(productName),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.5,
                  fit: BoxFit.contain,
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
                    backgroundColor: Color.fromARGB(
                        255, 255, 255, 255), // Warna sesuai preferensi
                  ),
                ),
              ],
            ),
          ),
        );
      },
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

=======
>>>>>>> 3d0ddc8 (Pembaruan Web)
  Widget _buildHeaderText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  void _updateStatus(BuildContext context, String docId, String status) async {
    try {
      await FirebaseFirestore.instance
          .collection('transaksi')
          .doc(docId)
          .update({
        'status': status,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Success: Status updated to $status'),
          backgroundColor:
              status == 'Completed' ? Colors.green[700] : Colors.red[700],
        ),
      );
    } catch (e) {
      print('Error updating status: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update status'),
          backgroundColor: Colors.red[700],
        ),
      );
    }
  }
}
