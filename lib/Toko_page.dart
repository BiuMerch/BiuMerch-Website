import 'package:apa/Store_Details_page.dart';
import 'package:apa/kategori_page.dart';
import 'package:apa/pemesanan.dart';
import 'package:apa/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:apa/login_page.dart';
import 'package:apa/Admin_page.dart';
import 'package:apa/produk_page.dart';
import 'package:apa/banner_page.dart';
import 'package:apa/tarik_dana.dart';
import 'package:apa/pesanan_table.dart';
<<<<<<< HEAD
=======
import 'package:shared_preferences/shared_preferences.dart';
>>>>>>> 3d0ddc8 (Pembaruan Web)

class TokoPage extends StatefulWidget {
  @override
  _TokoPageState createState() => _TokoPageState();
}

class _TokoPageState extends State<TokoPage> {
  String _selectedMenu = 'Toko';

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
<<<<<<< HEAD
                   _buildMenuItem(
=======
                    _buildMenuItem(
>>>>>>> 3d0ddc8 (Pembaruan Web)
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
<<<<<<< HEAD
                          MaterialPageRoute(builder: (context) => KategoriPage()),
=======
                          MaterialPageRoute(
                              builder: (context) => KategoriPage()),
>>>>>>> 3d0ddc8 (Pembaruan Web)
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
<<<<<<< HEAD
                          MaterialPageRoute(builder: (context) => PemesananPage()),
=======
                          MaterialPageRoute(
                              builder: (context) => PemesananPage()),
>>>>>>> 3d0ddc8 (Pembaruan Web)
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
                        'Toko',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Expanded(
                        child: TokoTable(), // Add the StoreTable here
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

class TokoTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('stores').snapshots(),
      builder: (context, snapshot) {
<<<<<<< HEAD
=======
        // Error handling
>>>>>>> 3d0ddc8 (Pembaruan Web)
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

<<<<<<< HEAD
=======
        // Loading state
>>>>>>> 3d0ddc8 (Pembaruan Web)
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

<<<<<<< HEAD
=======
        // No data state
>>>>>>> 3d0ddc8 (Pembaruan Web)
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No stores available'));
        }

<<<<<<< HEAD
        List<DataRow> rows = snapshot.data!.docs.map((doc) {
=======
        List<DataRow> rows = snapshot.data!.docs.asMap().entries.map((entry) {
          int index = entry.key; // Index for numbering
          var doc = entry.value;

>>>>>>> 3d0ddc8 (Pembaruan Web)
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          String docId = doc.id;

          String storeName = data['storeName'] ?? 'N/A';
          String phoneNumber = data['phoneNumber'] ?? 'N/A';
          String storeLogo = data['storeLogo'] ?? '';
          String storeDescription = data['storeDescription'] ?? 'N/A';
<<<<<<< HEAD
          bool approved = data['approved'] ?? false;

          return DataRow(
            cells: [
=======

          return DataRow(
            cells: [
              DataCell(Text((index + 1).toString())), // Row number
>>>>>>> 3d0ddc8 (Pembaruan Web)
              DataCell(Text(storeName)),
              DataCell(Text(phoneNumber)),
              DataCell(
                GestureDetector(
                  onTap: () => _showImageDialog(context, storeLogo, storeName),
<<<<<<< HEAD
                  child: _buildImageCell(storeLogo, storeName),
=======
                  child: storeLogo.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: storeLogo,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) {
                            // Log the error to get more details
                            print('Error loading image: $error');
                            return _buildPlaceholder(storeName);
                          },
                        )
                      : _buildPlaceholder(storeName),
>>>>>>> 3d0ddc8 (Pembaruan Web)
                ),
              ),
              DataCell(Text(storeDescription)),
              DataCell(
                Row(
                  children: [
<<<<<<< HEAD
                    if (!approved)
                      ElevatedButton(
                        onPressed: () => _approveStore(docId),
                        child: Text('Approve'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                      ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () => _cancelApproval(docId),
                      child: Text('Cancel'),
=======
                    ElevatedButton(
                      onPressed: () => _viewStoreDetails(context, data),
                      child: Text('Lihat Detail Toko'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[700],
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () => _confirmDeleteStore(context, docId),
                      child: Text('Delete'),
>>>>>>> 3d0ddc8 (Pembaruan Web)
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                    ),
                  ],
                ),
              ),
<<<<<<< HEAD
              DataCell(
                ElevatedButton(
                  onPressed: () => _viewStoreDetails(context, data),
                  child: Text('Lihat Detail Toko'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
              ),
=======
>>>>>>> 3d0ddc8 (Pembaruan Web)
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
<<<<<<< HEAD
=======
                DataColumn(label: _buildHeaderText('No')), // New column for numbering
>>>>>>> 3d0ddc8 (Pembaruan Web)
                DataColumn(label: _buildHeaderText('Store Name')),
                DataColumn(label: _buildHeaderText('Phone Number')),
                DataColumn(label: _buildHeaderText('Store Logo')),
                DataColumn(label: _buildHeaderText('Store Description')),
<<<<<<< HEAD
                DataColumn(label: _buildHeaderText('Manage Approval')),
                DataColumn(label: _buildHeaderText('Actions')),
=======
                DataColumn(label: _buildHeaderText('Actions')), // Actions column includes view and delete buttons
>>>>>>> 3d0ddc8 (Pembaruan Web)
              ],
              rows: rows,
            ),
          ),
        );
      },
    );
  }

<<<<<<< HEAD
  Widget _buildImageCell(String imageUrl, String storeName) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(4),
      ),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => _buildPlaceholder(storeName),
      ),
    );
  }

  Widget _buildPlaceholder(String storeName) {
    return Container(
      width: 80,
      height: 80,
      color: Colors.grey[300],
      child: Center(
        child: Text(
          storeName.isNotEmpty ? storeName[0].toUpperCase() : '?',
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

  void _viewStoreDetails(BuildContext context, Map<String, dynamic> storeData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StoreDetailsPage(storeData: storeData),
      ),
    );
  }

  Future<void> _approveStore(String docId) async {
    await FirebaseFirestore.instance.collection('stores').doc(docId).update({
      'approved': true,
    });
  }

  Future<void> _cancelApproval(String docId) async {
    await FirebaseFirestore.instance.collection('stores').doc(docId).update({
      'approved': false,
    });
  }

=======
  // Show confirmation dialog before deleting a store
  void _confirmDeleteStore(BuildContext context, String storeId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this store? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _deleteStore(storeId, context);
              },
              child: Text('Delete'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.red, // Red color for delete action
              ),
            ),
          ],
        );
      },
    );
  }

  // Delete store from Firestore
  void _deleteStore(String storeId, BuildContext context) {
    FirebaseFirestore.instance.collection('stores').doc(storeId).delete().then(
      (value) {
        print('Store deleted successfully');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Store deleted successfully')),
        );
      },
    ).catchError((error) {
      print('Failed to delete store: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete store: $error')),
      );
    });
  }

  // Image dialog with network image handling using CachedNetworkImage
>>>>>>> 3d0ddc8 (Pembaruan Web)
  void _showImageDialog(BuildContext context, String imageUrl, String storeName) {
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
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.contain,
<<<<<<< HEAD
                    placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => _buildPlaceholder(storeName),
=======
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        _buildPlaceholder(storeName),
>>>>>>> 3d0ddc8 (Pembaruan Web)
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  storeName,
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
<<<<<<< HEAD
=======

  // Placeholder widget for missing images
  Widget _buildPlaceholder(String storeName) {
    return Container(
      width: 50,
      height: 50,
      color: Colors.grey[300],
      child: Center(
        child: Text(
          storeName.isNotEmpty ? storeName[0].toUpperCase() : '?',
          style: TextStyle(
            color: Colors.grey[600],
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
    );
  }

  // Header text for the table
  Widget _buildHeaderText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  // Viewing store details
  void _viewStoreDetails(BuildContext context, Map<String, dynamic> storeData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StoreDetailsPage(storeData: storeData),
      ),
    );
  }
>>>>>>> 3d0ddc8 (Pembaruan Web)
}