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

  factory TopSellingProduct.fromMap(Map<String, dynamic> map) {
    return TopSellingProduct(
      name: map['name'],
      sales: map['sales'],
      price: map['price'],
      totalRevenue: map['totalRevenue'],
    );
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
  }

  String _selectedMenu = 'Dashboard';

  Future<List<TopSellingProduct>> getTopSellingProducts() async {
    final usersRef = FirebaseFirestore.instance.collection('users');
    final QuerySnapshot userSnapshot = await usersRef.get();

    Map<String, TopSellingProduct> productSales = {};

    for (var userDoc in userSnapshot.docs) {
      final transactionsRef = userDoc.reference.collection('transaksi');
      final QuerySnapshot transactionSnapshot = await transactionsRef.get();

      for (var transactionDoc in transactionSnapshot.docs) {
        Map<String, dynamic> transactionData =
            transactionDoc.data() as Map<String, dynamic>;

        // Only consider completed transactions
        if (transactionData['status'] == 'completed') {
          List<dynamic> stores = transactionData['stores'];
          for (var store in stores) {
            List<dynamic> items = store['items'];
            for (var item in items) {
              String productName = item['productName'];
              int quantity = item['quantity'];
              double price = item['productPrice'].toDouble();

              if (productSales.containsKey(productName)) {
                var existingProduct = productSales[productName]!;
                productSales[productName] = TopSellingProduct(
                  name: productName,
                  sales: existingProduct.sales + quantity,
                  price: price,
                  totalRevenue:
                      existingProduct.totalRevenue + (quantity * price),
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
    }

    List<TopSellingProduct> topProducts = productSales.values.toList()
      ..sort((a, b) => b.sales.compareTo(a.sales));

    // Return top 5 products or all if less than 5
    return topProducts.take(5).toList();
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
                                                      'Kategori Produk Terlaris',
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
                                                      8), // Optional, untuk jarak antara judul dan tabel
                                              _buildTopSellingProductsTable(),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
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
                      DataCell(Text('Rp ${product.price.toStringAsFixed(0)}')),
                      DataCell(Text(
                          'Rp ${product.totalRevenue.toStringAsFixed(0)}')),
                    ],
                  );
                }).toList(),
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
      onEnter: (_) => setState(() {}),
      onExit: (_) => setState(() {}),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          color: isSelected ? Colors.grey[300] : Colors.transparent,
          child: ListTile(
            leading: Icon(icon,
                color: isSelected ? Colors.green[700] : Colors.black),
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

  Widget _buildBarChart() {
    final data = [
      {'month': 'Jan', 'sales': 5},
      {'month': 'Feb', 'sales': 25},
      {'month': 'Mar', 'sales': 30},
      {'month': 'Apr', 'sales': 25},
    ];

    return CustomBarChart(data: data);
  }

  Widget _buildPieChart() {
    final data = [
      {'category': 'Makanan', 'sales': 35, 'color': Colors.blue},
      {'category': 'Jasa', 'sales': 25, 'color': Colors.red},
      {'category': 'Minuman', 'sales': 20, 'color': Colors.green},
      {'category': 'Cemilan', 'sales': 20, 'color': Colors.yellow},
    ];

    return CustomPieChart(data: data);
  }
}

class CustomBarChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  CustomBarChart({required this.data});

  @override
  Widget build(BuildContext context) {
    double maxSales = data
        .map((e) => e['sales'] as int)
        .reduce((a, b) => a > b ? a : b)
        .toDouble();

    return LayoutBuilder(
      builder: (context, constraints) {
        double barWidth = constraints.maxWidth / (data.length * 2 + 1);
        double maxHeight =
            constraints.maxHeight - 20; // Reduce maxHeight to avoid overflow
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: data.map((item) {
            double height = (item['sales'] as int) /
                maxSales *
                maxHeight; // Use reduced maxHeight
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: barWidth / 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: barWidth,
                    height: height,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 4),
                  Text(item['month'], style: TextStyle(fontSize: 10)),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class CustomPieChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  CustomPieChart({required this.data});

  @override
  Widget build(BuildContext context) {
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
                painter: PieChartPainter(data: data),
              ),
            ),
            SizedBox(width: 16), // Space between pie chart and labels
            // Labels
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: data.map((item) {
                return Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      color: item['color'],
                    ),
                    SizedBox(width: 8),
                    Text(
                      item['category'],
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
}

class PieChartPainter extends CustomPainter {
  final List<Map<String, dynamic>> data;

  PieChartPainter({required this.data});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width < size.height ? size.width / 2 : size.height / 2;

    double total = data
        .map((item) => item['sales'] as int)
        .reduce((a, b) => a + b)
        .toDouble();
    double startAngle = 0;

    for (var item in data) {
      final sweepAngle = 2 * 3.14159 * (item['sales'] as int) / total;
      final paint = Paint()
        ..style = PaintingStyle.fill
        ..color = item['color'];

      canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
          startAngle, sweepAngle, true, paint);
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
