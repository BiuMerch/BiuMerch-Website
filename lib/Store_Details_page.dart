import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:apa/Admin_page.dart';
import 'package:apa/banner_page.dart';
import 'package:apa/login_page.dart';
import 'package:apa/pemesanan.dart';
import 'package:apa/produk_page.dart';
import 'package:apa/tarik_dana.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreDetailsPage extends StatelessWidget {
  final Map<String, dynamic> storeData;

  const StoreDetailsPage({Key? key, required this.storeData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String storeName = storeData['storeName'] ?? 'N/A';
    String ownerId = storeData['ownerId'] ?? 'N/A';
    String email = storeData['email'] ?? 'N/A';
    String phoneNumber = storeData['phoneNumber'] ?? 'N/A';
    String storeDescription = storeData['storeDescription'] ?? 'N/A';
    String storeLogo = storeData['storeLogo'] ?? '';
    List<dynamic> productIds = storeData['product'] ?? []; // Product IDs array

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
                color: Colors.white.withOpacity(0.9),
                child: Column(
                  children: [
                    // Back button
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
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
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 8,
                                  offset: Offset(2, 4),
                                ),
                              ],
                            ),
                            child: Image.asset('assets/logo.png'),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'BIU Merch',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green[700],
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    _buildDivider(),
                    _buildMenuItem(context, Icons.dashboard, 'Dashboard', () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => AdminPage()),
                      );
                    }),
                    _buildDivider(),
                    _buildMenuItem(context, Icons.monetization_on, 'Tarik Dana',
                        () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => WalletPage()),
                      );
                    }),
                    _buildDivider(),
                    _buildMenuItem(context, Icons.inventory, 'Produk', () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => ProdukPage()),
                      );
                    }),
                    _buildDivider(),
                    _buildMenuItem(context, Icons.category, 'Kategori', () {
                      // Handle Kategori navigation
                    }),
                    _buildDivider(),
                    _buildMenuItem(context, Icons.payment, 'Transaksi', () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PemesananPage()),
                      );
                    }),
                    _buildDivider(),
                    _buildMenuItem(context, Icons.flag, 'Banner', () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => BannerPage()),
                      );
                    }),
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
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(2, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(
                            child: storeLogo.isNotEmpty
                                ? GestureDetector(
                                    onTap: () => _showImageDialog(
                                        context, storeLogo, storeName),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        storeLogo,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Icon(Icons.store,
                                              size: 100, color: Colors.grey);
                                        },
                                      ),
                                    ),
                                  )
                                : Icon(Icons.store,
                                    size: 100, color: Colors.grey),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Store Name: $storeName',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text('Owner ID: $ownerId',
                              style: TextStyle(fontSize: 18)),
                          SizedBox(height: 8),
                          Text('Email: $email', style: TextStyle(fontSize: 18)),
                          SizedBox(height: 8),
                          Text('Phone Number: $phoneNumber',
                              style: TextStyle(fontSize: 18)),
                          SizedBox(height: 8),
                          Text('Description: $storeDescription',
                              style: TextStyle(fontSize: 18)),
                          SizedBox(height: 16),
                          Text(
                            'Produk:',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          // FutureBuilder for displaying the products
                          FutureBuilder<DocumentSnapshot>(
                            future: FirebaseFirestore.instance
                                .collection('stores')
                                .doc(storeData['idstore'])
                                .get(),
                            builder: (context, storeSnapshot) {
                              if (storeSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (storeSnapshot.hasError) {
                                return Text('Error: ${storeSnapshot.error}');
                              } else if (!storeSnapshot.hasData ||
                                  !storeSnapshot.data!.exists) {
                                return Text('Toko tidak ditemukan.');
                              } else {
                                Map<String, dynamic> storeData =
                                    storeSnapshot.data!.data()
                                        as Map<String, dynamic>;
                                String storeId = storeSnapshot.data!.id;

                                return FutureBuilder<QuerySnapshot>(
                                  future: FirebaseFirestore.instance
                                      .collection('products')
                                      .where('storeId', isEqualTo: storeId)
                                      .get(),
                                  builder: (context, productSnapshot) {
                                    if (productSnapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    } else if (productSnapshot.hasError) {
                                      return Text(
                                          'Error: ${productSnapshot.error}');
                                    } else if (!productSnapshot.hasData ||
                                        productSnapshot.data!.docs.isEmpty) {
                                      return Text(
                                          'Tidak ada produk untuk toko ini.');
                                    } else {
                                      List<QueryDocumentSnapshot> products =
                                          productSnapshot.data!.docs;
                                      return SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: DataTable(
                                          columns: [
                                            DataColumn(label: Text('No.')),
                                            DataColumn(label: Text('Name')),
                                            DataColumn(
                                                label: Text('Description')),
                                            DataColumn(label: Text('Image')),
                                            DataColumn(label: Text('Category')),
                                            DataColumn(label: Text('Price')),
                                            DataColumn(label: Text('Rating')),
                                            DataColumn(label: Text('Stock')),
                                          ],
                                          rows: products
                                              .asMap()
                                              .entries
                                              .map((entry) {
                                            int index = entry.key;
                                            QueryDocumentSnapshot product =
                                                entry.value;
                                            Map<String, dynamic> productData =
                                                product.data()
                                                    as Map<String, dynamic>;
                                            return DataRow(
                                              cells: [
                                                DataCell(Text(
                                                    (index + 1).toString())),
                                                DataCell(Text(productData[
                                                        'name'] ??
                                                    'N/A')),
                                                DataCell(Text(productData[
                                                        'description'] ??
                                                    'N/A')),
                                                DataCell(
                                                  GestureDetector(
                                                    onTap: () {
                                                      _showImageDialog(
                                                          context,
                                                          productData[
                                                                  'imageUrls']
                                                              .first,
                                                          productData['name']);
                                                    },
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          productData[
                                                                  'imageUrls']
                                                              .first,
                                                      width: 50,
                                                      height: 50,
                                                      fit: BoxFit.cover,
                                                      placeholder: (context,
                                                              url) =>
                                                          Center(
                                                              child:
                                                                  CircularProgressIndicator()),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(
                                                              Icons
                                                                  .image_not_supported,
                                                              size: 50),
                                                    ),
                                                  ),
                                                ),
                                                DataCell(Text(productData[
                                                        'category'] ??
                                                    'N/A')),
                                                DataCell(Text(productData[
                                                            'price'] !=
                                                        null
                                                    ? 'Rp ${productData['price']}'
                                                    : 'N/A')),
                                                DataCell(Text(productData[
                                                            'rating'] !=
                                                        null
                                                    ? productData['rating']
                                                        .toString()
                                                    : 'N/A')),
                                                DataCell(Text(productData[
                                                            'stock'] !=
                                                        null
                                                    ? productData['stock']
                                                        .toString()
                                                    : 'N/A')),
                                              ],
                                            );
                                          }).toList(),
                                        ),
                                      );
                                    }
                                  },
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showImageDialog(BuildContext context, String imageUrl, String productName) {
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
                imageUrl.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: imageUrl,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            _buildPlaceholder(productName),
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.5,
                        fit: BoxFit.contain,
                      )
                    : Icon(Icons.store, size: 100, color: Colors.grey),
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
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
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

  Widget _buildMenuItem(
      BuildContext context, IconData icon, String label, Function onTap) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF0B4D3B)),
      title: Text(
        label,
        style: TextStyle(color: Color(0xFF0B4D3B)),
      ),
      onTap: () => onTap(),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Color(0xFF0B4D3B),
      thickness: 1.0,
    );
  }
}
