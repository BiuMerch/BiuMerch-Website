import 'package:apa/Toko_page.dart';
import 'package:apa/pemesanan.dart';
import 'package:apa/tarik_dana.dart';
import 'package:apa/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:apa/login_page.dart';
import 'package:apa/produk_page.dart';
import 'package:apa/banner_page.dart';
import 'package:apa/kategori_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class TopSellingProduct {
  final String name;
  final int sales;
  final double price;
  final double totalRevenue;

  TopSellingProduct({
    required this.name,
    required this.sales,
    required this.price,
    required this.totalRevenue,
  });
}

class StorePerformance {
  final String name;
  int sales;
  double revenue;
  String tier;

  StorePerformance({
    required this.name,
    this.sales = 0,
    this.revenue = 0.0,
    this.tier = '',
  });

  void updatePerformance(int quantity, double price) {
    sales += quantity;
    revenue += quantity * price;
  }
}

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

Future<int> getCollectionCount(String collectionName) async {
  final collection = FirebaseFirestore.instance.collection(collectionName);
  final snapshot = await collection.get();
  return snapshot.docs.length;
}

class _AdminPageState extends State<AdminPage> {
  late Future<List<TopSellingProduct>> _topSellingProducts;
  late Future<List<StorePerformance>> _storePerformances;

  Future<int>? _userCount;
  Future<int>? _storeCount;
  Future<int>? _productCount;
  Future<int>? _categoryCount;

  @override
  void initState() {
    super.initState();
    _userCount = getCollectionCount('users');
    _storeCount = getCollectionCount('stores');
    _productCount = getCollectionCount('products');
    _categoryCount = getCollectionCount('category');
    _topSellingProducts = getTopSellingProducts();
    _storePerformances = getStorePerformances();
    _checkLoginStatus(); // Check login status when the app starts
  }

  void _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username'); // Get the stored username

    if (username == null) {
      // User is not logged in, navigate to the LoginPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    }
  }

  String _selectedMenu = 'Dashboard';

  Future<List<StorePerformance>> getStorePerformances() async {
    final transactionsRef =
        FirebaseFirestore.instance.collection('transaction');

    // Ambil semua transaksi dengan status 'completed'
    final QuerySnapshot transactionSnapshot =
        await transactionsRef.where('status', isEqualTo: 'completed').get();

    Map<String, StorePerformance> storePerformances = {};

    for (var transactionDoc in transactionSnapshot.docs) {
      Map<String, dynamic> transactionData =
          transactionDoc.data() as Map<String, dynamic>;

      // Loop di array 'stores' yang ada dalam dokumen transaksi
      List<dynamic> stores = transactionData['stores'] ?? [];

      for (var store in stores) {
        String storeId = store['storeId'];
        String storeName = store['storeName'] ?? 'Toko Tidak Diketahui';
        double totalStoreRevenue = 0;
        int totalStoreSales = 0;

        // Ambil item dari sub-koleksi 'items' di dalam transaksi ini
        final itemsSnapshot =
            await transactionDoc.reference.collection('items').get();

        for (var itemDoc in itemsSnapshot.docs) {
          Map<String, dynamic> itemData =
              itemDoc.data() as Map<String, dynamic>;
          List<dynamic> products = itemData['products'] ?? [];

          // Loop melalui produk untuk menghitung total penjualan dan pendapatan
          for (var product in products) {
            int quantity = product['quantity'] ?? 0;
            double price = (product['productPrice'] ?? 0).toDouble();

            totalStoreSales += quantity;
            totalStoreRevenue += quantity * price;
          }
        }

        // Update performa toko jika sudah ada, jika belum tambahkan baru
        if (storePerformances.containsKey(storeId)) {
          storePerformances[storeId]!.sales += totalStoreSales;
          storePerformances[storeId]!.revenue += totalStoreRevenue;
        } else {
          storePerformances[storeId] = StorePerformance(
            name: storeName,
            sales: totalStoreSales,
            revenue: totalStoreRevenue,
          );
        }
      }
    }

    List<StorePerformance> performances = storePerformances.values.toList()
      ..sort((a, b) => b.revenue.compareTo(a.revenue));

    // Tentukan tier (Top, Mid, Bottom)
    int totalStores = performances.length;
    int topThreshold = (totalStores * 0.2).ceil(); // Top 20%
    int bottomThreshold = (totalStores * 0.8).floor(); // Bottom 20%

    for (int i = 0; i < performances.length; i++) {
      if (i < topThreshold) {
        performances[i].tier = 'Top';
      } else if (i >= bottomThreshold) {
        performances[i].tier = 'Bottom';
      } else {
        performances[i].tier = 'Mid';
      }
    }

    return performances;
  }

  Future<List<TopSellingProduct>> getTopSellingProducts() async {
    final transactionsRef =
        FirebaseFirestore.instance.collection('transaction');
    final QuerySnapshot transactionSnapshot = await transactionsRef.get();

    print('Total transactions: ${transactionSnapshot.docs.length}');

    Map<String, TopSellingProduct> productSales = {};

    for (var transactionDoc in transactionSnapshot.docs) {
      final itemsRef = transactionDoc.reference.collection('items');
      final QuerySnapshot itemSnapshot = await itemsRef.get();

      print(
          'Transaction ${transactionDoc.id} has ${itemSnapshot.docs.length} items');

      for (var itemDoc in itemSnapshot.docs) {
        Map<String, dynamic> itemData = itemDoc.data() as Map<String, dynamic>;
        List<dynamic> products = itemData['products'] ?? [];

        print('Item has ${products.length} products');

        for (var product in products) {
          print('Product status: ${product['status']}');

          if (product['status'] == 'completed') {
            String productName = product['productName'];
            int quantity = product['quantity'];
            double price = product['productPrice'].toDouble();

            print(
                'Processing completed product: $productName, Quantity: $quantity, Price: $price');

            if (productSales.containsKey(productName)) {
              var existingProduct = productSales[productName]!;
              productSales[productName] = TopSellingProduct(
                name: productName,
                sales: existingProduct.sales + quantity,
                price: price,
                totalRevenue: existingProduct.totalRevenue + (quantity * price),
              );
            } else {
              productSales[productName] = TopSellingProduct(
                name: productName,
                sales: quantity,
                price: price,
                totalRevenue: quantity * price,
              );
            }
          }
        }
      }
    }

    List<TopSellingProduct> topProducts = productSales.values.toList()
      ..sort((a, b) => b.sales.compareTo(a.sales));

    print('Total unique products: ${topProducts.length}');
    topProducts.forEach((product) {
      print(
          '${product.name}: ${product.sales} sales, Total Revenue: ${product.totalRevenue}');
    });

    return topProducts;
  }

  Future<Map<String, int>> getMonthlyTransactions() async {
    final transactionsRef =
        FirebaseFirestore.instance.collection('transaction');

    // Query all 'completed' transactions
    final QuerySnapshot transactionSnapshot =
        await transactionsRef.where('status', isEqualTo: 'completed').get();

    Map<String, int> monthlyTransactions = {};

    // Loop through the transactions to extract the timestamp
    for (var doc in transactionSnapshot.docs) {
      var transactionData = doc.data() as Map<String, dynamic>;
      Timestamp timestamp = transactionData['timestamp'];

      // Convert the timestamp to a DateTime object
      DateTime transactionDate = timestamp.toDate();

      // Format the date to 'MMM yyyy' (e.g., "Jan 2024")
      String formattedDate = DateFormat('MMM yyyy').format(transactionDate);

      // Increment the count for each month
      if (monthlyTransactions.containsKey(formattedDate)) {
        monthlyTransactions[formattedDate] =
            monthlyTransactions[formattedDate]! + 1;
      } else {
        monthlyTransactions[formattedDate] = 1;
      }
    }

    return monthlyTransactions;
  }

  Future<Map<String, int>> getCategoryVisitData() async {
  // Collection reference for users
  final usersCollection = FirebaseFirestore.instance.collection('users');
  
  // Map to store the total visits for each category
  Map<String, int> categoryVisitCounts = {
    'Elektronik': 0,
    'Jasa': 0,
    'Makanan & Minuman': 0,
    'Perlengkapan': 0,
  };

  // Get all user documents
  final QuerySnapshot usersSnapshot = await usersCollection.get();

  // Loop through each user document
  for (var userDoc in usersSnapshot.docs) {
    // Get the sub-collection 'categoryVisits' for each user
    final categoryVisitsRef = userDoc.reference.collection('categoryVisits');
    final QuerySnapshot categoryVisitsSnapshot = await categoryVisitsRef.get();

    // Loop through each document in the 'categoryVisits' sub-collection
    for (var visitDoc in categoryVisitsSnapshot.docs) {
      Map<String, dynamic> visitData = visitDoc.data() as Map<String, dynamic>;

      // Safely get the category and visitCount, providing default values if they are null
      String category = visitData['category'] ?? 'Unknown';
      int visitCount = visitData['visitCount'] ?? 0;

      // Add the visit count to the appropriate category
      if (categoryVisitCounts.containsKey(category)) {
        categoryVisitCounts[category] = categoryVisitCounts[category]! + visitCount;
      }
    }
  }

  return categoryVisitCounts;
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
                        setState(() {
                          _selectedMenu = 'Dashboard';
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
                    // Expanded to ensure the button is pushed to the bottom
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
                        _selectedMenu,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Expanded(
                        child: SingleChildScrollView(
                          child: _selectedMenu == 'Dashboard'
                              ? Column(
                                  children: [
                                    // Use Row to place charts side by side
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 200,
                                            margin: EdgeInsets.only(right: 16),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 1,
                                                  blurRadius: 3,
                                                  offset: Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text('Transaksi Perbulan',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Expanded(
                                                      child: _buildBarChart()),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 200,
                                            margin: EdgeInsets.only(left: 16),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 1,
                                                  blurRadius: 3,
                                                  offset: Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      'Kategori Paling banyak Di kunjungi',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Expanded(
                                                      child: _buildPieChart()),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        _buildStatBox('Users', _userCount),
                                        _buildStatBox('Stores', _storeCount),
                                        _buildStatBox(
                                            'Products', _productCount),
                                        _buildStatBox(
                                            'category', _categoryCount),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 16),
                                              Text(
                                                'Produk Terlaris',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                  height:
                                                      8), // Optional, for spacing between the title and table
                                              _buildTopSellingProductsTable(),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 16),
                                              Text(
                                                'Performa Toko',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                  height:
                                                      8), // Optional, for spacing between the title and table
                                              _buildStorePerformanceTable(), // Table for store performance
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : Center(
                                  child: Text('Select a menu to see content')),
                        ),
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

  Widget _buildStorePerformanceTable() {
    return FutureBuilder<List<StorePerformance>>(
      future: getStorePerformances(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Tidak ada data performa toko.'));
        } else {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('No.')),
                    DataColumn(label: Text('Nama Toko')),
                    DataColumn(label: Text('Tier')),
                    DataColumn(label: Text('Total Penjualan')),
                    DataColumn(label: Text('Total Pendapatan')),
                  ],
                  rows: snapshot.data!.asMap().entries.map((entry) {
                    int idx = entry.key;
                    StorePerformance store = entry.value;
                    return DataRow(
                      cells: [
                        DataCell(Text('${idx + 1}')),
                        DataCell(Text(store.name)),
                        DataCell(
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getTierColor(store.tier),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              store.tier,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        DataCell(Text(
                            '${store.sales}')), // Tampilkan total penjualan
                        DataCell(Text(
                            'Rp ${store.revenue.toStringAsFixed(0)}')), // Tampilkan total pendapatan
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Color _getTierColor(String tier) {
    switch (tier) {
      case 'Top':
        return Colors.green;
      case 'Mid':
        return Colors.orange;
      case 'Bottom':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildTopSellingProductsTable() {
    return FutureBuilder<List<TopSellingProduct>>(
      future: _topSellingProducts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Tidak ada data produk terlaris.'));
        } else {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('No.')),
                    DataColumn(label: Text('Nama Produk')),
                    DataColumn(label: Text('Total Penjualan')),
                    DataColumn(label: Text('Harga')),
                    DataColumn(label: Text('Total Pendapatan')),
                  ],
                  rows: snapshot.data!.asMap().entries.map((entry) {
                    int idx = entry.key;
                    TopSellingProduct product = entry.value;
                    return DataRow(
                      cells: [
                        DataCell(Text('${idx + 1}')),
                        DataCell(Text(product.name)),
                        DataCell(Text('${product.sales}')),
                        DataCell(
                            Text('Rp ${product.price.toStringAsFixed(0)}')),
                        DataCell(Text(
                            'Rp ${product.totalRevenue.toStringAsFixed(0)}')),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildStatBox(String title, Future<int>? countFuture) {
    return FutureBuilder<int>(
      future: countFuture,
      builder: (context, snapshot) {
        String countText = snapshot.connectionState == ConnectionState.waiting
            ? 'Loading...'
            : snapshot.hasError
                ? 'Error'
                : snapshot.data.toString();

        return Expanded(
          child: Container(
            margin: EdgeInsets.all(8.0),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _getIconForTitle(title),
                  size: 40,
                  color: Colors.green[700],
                ),
                SizedBox(height: 8),
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 8),
                Text(
                  countText,
                  style: TextStyle(fontSize: 22),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  IconData _getIconForTitle(String title) {
    switch (title) {
      case 'Users':
        return Icons.supervised_user_circle;
      case 'Stores':
        return Icons.store;
      case 'Products':
        return Icons.production_quantity_limits;
      case 'Categories':
        return Icons.category;
      default:
        return Icons.help;
    }
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
  return MouseRegion(
    onEnter: (_) {
      // Avoid unnecessary setState calls here
      // setState(() {});
    },
    onExit: (_) {
      // Avoid unnecessary setState calls here
      // setState(() {});
    },
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        color: isSelected ? Colors.grey[300] : Colors.transparent,
        child: ListTile(
          leading: Icon(icon, color: isSelected ? Colors.green[700] : Colors.black),
          title: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.green[700] : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _buildPieChart() {
  return FutureBuilder<Map<String, int>>(
    future: getCategoryVisitData(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return Center(child: Text('No visit data available.'));
      } else {
        return CustomPieChart(categoryVisits: snapshot.data!);
      }
    },
  );
}


  Widget _buildBarChart() {
    return FutureBuilder<Map<String, int>>(
      future: getMonthlyTransactions(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No transactions available.'));
        } else {
          return CustomBarChart(monthlyTransactions: snapshot.data!);
        }
      },
    );
  }
}
  

class CustomBarChart extends StatelessWidget {
  final Map<String, int> monthlyTransactions;

  CustomBarChart({required this.monthlyTransactions});

  @override
  Widget build(BuildContext context) {
    // Extract formatted month names and transaction counts
    List<String> months = monthlyTransactions.keys.toList();
    List<int> transactionCounts = monthlyTransactions.values.toList();

    // Find the maximum number of transactions for scaling the bar heights
    int maxSales = transactionCounts.isNotEmpty
        ? transactionCounts.reduce((a, b) => a > b ? a : b)
        : 1;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Set a fixed bar width, and ensure it's not too wide, with a max width
        double barWidth = constraints.maxWidth / (months.length * 2 + 1);
        barWidth = barWidth > 40
            ? 40
            : barWidth; // Limit the bar width to 40 pixels max

        // Set the maximum height to be a smaller fraction of the container height
        double maxHeight =
            constraints.maxHeight * 0.6; // Make it 60% of available height

        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment:
              MainAxisAlignment.center, // Center the bars horizontally
          children: List.generate(months.length, (index) {
            double height = transactionCounts[index] / maxSales * maxHeight;

            return Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 8), // Padding between bars
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: barWidth, // Fixed width for each bar
                    height: height,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 4),
                  Text(
                    months[index],
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}

class CustomPieChart extends StatelessWidget {
  final Map<String, int> categoryVisits;

  CustomPieChart({required this.categoryVisits});

  @override
  Widget build(BuildContext context) {
    // Get total visit counts
    int totalVisits = categoryVisits.values.reduce((a, b) => a + b);

    return LayoutBuilder(
      builder: (context, constraints) {
        double radius = constraints.maxWidth < constraints.maxHeight
            ? constraints.maxWidth / 2
            : constraints.maxHeight / 2;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Pie chart
            Container(
              width: radius * 2,
              height: radius * 2,
              child: CustomPaint(
                painter: PieChartPainter(categoryVisits: categoryVisits),
              ),
            ),
            SizedBox(width: 16), // Space between pie chart and labels
            // Labels
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: categoryVisits.entries.map((entry) {
                String category = entry.key;
                int visits = entry.value;
                return Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      color: _getCategoryColor(category),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '$category: $visits visits',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }

  Color _getCategoryColor(String category) {
    // Define a color for each category
    switch (category) {
      case 'Elektronik':
        return Colors.blue;
      case 'Jasa':
        return Colors.red;
      case 'Makanan & Minuman':
        return Colors.green;
      case 'Perlengkapan':
        return Colors.yellow;
      default:
        return Colors.grey;
    }
  }
}

class PieChartPainter extends CustomPainter {
  final Map<String, int> categoryVisits;

  PieChartPainter({required this.categoryVisits});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width < size.height ? size.width / 2 : size.height / 2;

    int totalVisits = categoryVisits.values.reduce((a, b) => a + b);
    double startAngle = 0;

    categoryVisits.forEach((category, visits) {
      final sweepAngle = (visits / totalVisits) * 2 * 3.14159;
      final paint = Paint()
        ..style = PaintingStyle.fill
        ..color = _getCategoryColor(category);

      canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
          startAngle, sweepAngle, true, paint);
      startAngle += sweepAngle;
    });
  }

  Color _getCategoryColor(String category) {
    // Define a color for each category
    switch (category) {
      case 'Elektronik':
        return Colors.blue;
      case 'Jasa':
        return Colors.red;
      case 'Makanan & Minuman':
        return Colors.green;
      case 'Perlengkapan':
        return Colors.yellow;
      default:
        return Colors.grey;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

