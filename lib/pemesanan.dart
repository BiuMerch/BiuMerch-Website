import 'package:apa/Toko_page.dart';
import 'package:apa/kategori_page.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

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
                color: Colors.grey[200]!
                    .withOpacity(0.9), // Slightly transparent sidebar
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
  return FutureBuilder<QuerySnapshot>(
    future: _fetchTransactionStatus(),
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

      // Extract counts from the snapshot
      int pendingCount = 0;
      int completedCount = 0;
      int canceledCount = 0;
      int onpaidCount = 0;

      for (var doc in snapshot.data!.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        String status = (data['status'] ?? 'N/A').toLowerCase();

        if (status == 'pending') {
          pendingCount++;
        } else if (status == 'completed') {
          completedCount++;
          } else if (status == 'on-paid') {
          onpaidCount++;
        } else if (status == 'cancel') {
          canceledCount++;
        }
      }

      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatusBox('Menunggu Konfirmasi', pendingCount, Color.fromARGB(255, 57, 168, 62)),
          _buildStatusBox('Transaksi Di Proses', onpaidCount, Color.fromARGB(255, 57, 168, 62)), // Example color for process status
          _buildStatusBox('Transaksi Gagal', canceledCount, Color.fromARGB(255, 57, 168, 62)),
          _buildStatusBox('Transaksi Selesai', completedCount, Color.fromARGB(255, 57, 168, 62)),
        ],
      );
    },
  );
}

// Method to fetch transaction data along with items sub-collection
Future<QuerySnapshot> _fetchTransactionStatus() async {
  QuerySnapshot transactionSnapshot = await FirebaseFirestore.instance.collection('transaction').get();

  // List to hold the future operations for fetching sub-collection data
  List<Future<void>> futures = [];

  // Temporary counters
  int pendingCount = 0;
  int completedCount = 0;
  int canceledCount = 0;
  int onpaidCount = 0;

  for (var doc in transactionSnapshot.docs) {
    String docId = doc.id;

    // Add futures for each sub-collection fetch
    futures.add(
      FirebaseFirestore.instance
          .collection('transaction')
          .doc(docId)
          .collection('items')
          .get()
          .then((itemsSnapshot) {
        for (var itemDoc in itemsSnapshot.docs) {
          Map<String, dynamic> itemData = itemDoc.data() as Map<String, dynamic>;
          String status = (itemData['status'] ?? 'N/A').toLowerCase();

          if (status == 'waiting-store-confirmation') {
            pendingCount++;
          } else if (status == 'completed') {
            completedCount++;
          } else if (status == 'cancel') {
            canceledCount++;
          }
        }
      }),
    );
  }

  // Wait for all futures to complete
  await Future.wait(futures);

  // Return a dummy snapshot with processed counts (we simulate that here, you can adapt this to your needs)
  return transactionSnapshot;
}

Widget _buildStatusBox(String label, int count, Color color) {
  return Expanded(
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$label:",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "$count",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.white,
              ),
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
      stream: FirebaseFirestore.instance.collection('transaction').snapshots(),
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

          // Fetch main transaction fields
          String customerName = data['customerName'] ?? 'N/A';
          String customerPhone = data['customerPhone'] ?? 'N/A';
          String status = data['status'] ?? 'N/A';
          int totalPrice = data['totalPrice'] ?? 0;
          String storeId = '';
          String storeName = '';
          Timestamp timestamp =
              data['timestamp'] as Timestamp? ?? Timestamp.now();

          // Fetch store information
          List<dynamic> stores = data['stores'] ?? [];
          if (stores.isNotEmpty) {
            Map<String, dynamic> firstStore = stores[0];
            storeId = firstStore['storeId'] ?? 'N/A';
            storeName = firstStore['storeName'] ?? 'N/A';
          }

          rows.add(DataRow(
            cells: [
              DataCell(Text(rowNumber.toString())), // Row number
              DataCell(Text(docId)), // Added docId
              DataCell(Text(customerName)), // Customer name
              DataCell(Text(customerPhone)), // Customer phone
              DataCell(Text(storeName)), // Store name
              DataCell(Text(status)), // Status
              DataCell(Text(
                  'Rp ${totalPrice.toString()}')), // Total Price with Rp format
              DataCell(Text(timestamp.toDate().toString())), // Timestamp
              DataCell(
                IconButton(
                  icon: Icon(Icons.list,
                      color: Colors.green[700]), // Green plus icon
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return FutureBuilder<QuerySnapshot>(
                          future: FirebaseFirestore.instance
                              .collection('transaction')
                              .doc(docId)
                              .collection('items')
                              .get(),
                          builder: (context, subSnapshot) {
                            if (subSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }

                            if (!subSnapshot.hasData ||
                                subSnapshot.data!.docs.isEmpty) {
                              return Center(child: Text('No items available'));
                            }

                            List<Widget> itemDetails = [];

                            for (var itemDoc in subSnapshot.data!.docs) {
                              Map<String, dynamic> itemData =
                                  itemDoc.data() as Map<String, dynamic>;

                              List<dynamic> products =
                                  itemData['products'] ?? [];
                              if (products.isNotEmpty) {
                                for (var product in products) {
                                  Map<String, dynamic> productData =
                                      product as Map<String, dynamic>;

                                  String productName =
                                      productData['productName'] ?? 'N/A';
                                  String productImage =
                                      productData['productImage'] ?? '';
                                  int productPrice =
                                      productData['productPrice'] ?? 0;
                                  int quantity = productData['quantity'] ?? 0;
                                  String category =
                                      productData['category'] ?? 'N/A';
                                  int totalPriceProduct =
                                      productData['totalPriceProduct'] ?? 0;
                                  String status =
                                      productData['status'] ?? 'N/A';
                                  Timestamp productTimestamp =
                                      productData['timestamp'] as Timestamp? ??
                                          Timestamp.now();

                                  itemDetails.add(
                                    ListTile(
                                      leading: Image.network(productImage,
                                          width: 50, height: 50),
                                      title: Text(productName),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Category: $category'),
                                          Text('Quantity: $quantity'),
                                          Text('Status: $status'),
                                          Text(
                                              'Total Price: Rp.${totalPriceProduct.toString()}'),
                                          Text(
                                              'Timestamp: ${productTimestamp.toDate()}'),
                                        ],
                                      ),
                                      trailing: Text(
                                          'Price: Rp.${productPrice.toString()}'),
                                    ),
                                  );
                                }
                              }
                            }

                            return ListView(
                              padding: EdgeInsets.all(10),
                              children: itemDetails,
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ));

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
                DataColumn(
                    label:
                        _buildHeaderText('ID Transaction')), // Column for docId
                DataColumn(label: _buildHeaderText('Customer Name')),
                DataColumn(label: _buildHeaderText('Customer Phone')),
                DataColumn(label: _buildHeaderText('Store Name')),
                DataColumn(label: _buildHeaderText('Status')),
                DataColumn(label: _buildHeaderText('Total Price')),
                DataColumn(label: _buildHeaderText('Timestamp')),
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
        color: Colors.black87,
      ),
    );
  }

  void _updateStatus(BuildContext context, String docId, String status) async {
    try {
      await FirebaseFirestore.instance
          .collection('transaction')
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
