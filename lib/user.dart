import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:apa/login_page.dart';
import 'package:apa/main.dart';
import 'package:apa/Toko_page.dart';
import 'package:apa/pemesanan.dart';
import 'package:apa/tarik_dana.dart';
import 'package:apa/produk_page.dart';
import 'package:apa/banner_page.dart';
import 'package:apa/kategori_page.dart';
import 'package:apa/Admin_page.dart';
<<<<<<< HEAD
=======
import 'package:shared_preferences/shared_preferences.dart';
>>>>>>> 3d0ddc8 (Pembaruan Web)

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String _selectedMenu = 'user';
<<<<<<< HEAD

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
                    Icons.supervised_user_circle_rounded,
                    'user',
                    () {
                      setState(() {
                        _selectedMenu = 'user';
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PemesananPage()),
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
=======
  String _selectedFilter = 'Semua'; // Filter state

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
                      Icons.supervised_user_circle_rounded,
                      'User',
                      () {
                        setState(() {
                          _selectedMenu = 'user';
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
                          MaterialPageRoute(
                              builder: (context) => BannerPage()),
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
>>>>>>> 3d0ddc8 (Pembaruan Web)
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
<<<<<<< HEAD
                      Text(
                        'User',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
=======
                      _buildFilterDropdown(), // Add filter dropdown here
>>>>>>> 3d0ddc8 (Pembaruan Web)
                      SizedBox(height: 16),
                      Expanded(
                        child: _buildUserTable(), // Add the UserTable here
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

<<<<<<< HEAD
=======
  // Build filter dropdown
  Widget _buildFilterDropdown() {
    return Row(
      children: [
        Text('Filter: ', style: TextStyle(fontSize: 16)),
        SizedBox(width: 8),
        DropdownButton<String>(
          value: _selectedFilter,
          items: [
            DropdownMenuItem(value: 'Semua', child: Text('Semua')),
            DropdownMenuItem(value: 'Penjual', child: Text('Penjual')),
            DropdownMenuItem(value: 'Pembeli', child: Text('Pembeli')),
          ],
          onChanged: (value) {
            setState(() {
              _selectedFilter = value!;
            });
          },
        ),
      ],
    );
  }

  Widget _buildUserTable() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        // Loading State
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        // No Data State
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No users found.'));
        }

        var users = snapshot.data!.docs;

        // Query all stores and cache them for role checking
        return FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance.collection('stores').get(),
          builder: (context, storeSnapshot) {
            if (storeSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            Map<String, bool> ownerStoreMap = {};
            if (storeSnapshot.hasData) {
              for (var store in storeSnapshot.data!.docs) {
                var storeData = store.data() as Map<String, dynamic>;
                ownerStoreMap[storeData['ownerId']] = true;
              }
            }

            // Filter users based on the selected filter
            List<QueryDocumentSnapshot> filteredUsers = users.where((user) {
              var data = user.data() as Map<String, dynamic>;
              String userId = user.id;
              bool isSeller = ownerStoreMap.containsKey(userId);

              if (_selectedFilter == 'Penjual') {
                return isSeller;
              } else if (_selectedFilter == 'Pembeli') {
                return !isSeller;
              }
              return true; // 'Semua' filter
            }).toList();

            List<DataRow> rows = filteredUsers.asMap().entries.map((entry) {
              int index = entry.key;
              QueryDocumentSnapshot user = entry.value;
              var data = user.data() as Map<String, dynamic>;
              String userId = user.id;

              // Check for both 'phoneNumber' and 'phone', and ensure the value is not empty
              String phoneNumber = (data['phoneNumber'] != null &&
                      data['phoneNumber'].toString().isNotEmpty)
                  ? data['phoneNumber']
                  : (data['phone'] != null &&
                          data['phone'].toString().isNotEmpty)
                      ? data['phone']
                      : 'No phone number available';

              // Check if user is a seller
              String userRole = ownerStoreMap.containsKey(userId)
                  ? 'Penjual'
                  : 'Pembeli';

              return DataRow(cells: [
                DataCell(Text('${index + 1}')), // Serial number
                DataCell(Text(data['username'] ?? '')),
                DataCell(Text(data['email'] ?? '')),
                DataCell(Text(phoneNumber)), // Phone number with fallback
                DataCell(Text(userRole)), // Display user role (Seller/Buyer)
                DataCell(
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _confirmDeleteUser(context, userId),
                  ),
                ),
              ]);
            }).toList();

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  columnSpacing: 16, // Adjust spacing if needed
                  columns: [
                    DataColumn(label: Text('No')), // Serial number header
                    DataColumn(label: Text('Username')),
                    DataColumn(label: Text('Email')),
                    DataColumn(label: Text('Phone Number')),
                    DataColumn(label: Text('Role')), // New column for Role (Seller/Buyer)
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: rows,
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Confirmation Dialog for Deletion
  void _confirmDeleteUser(BuildContext context, String userId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text(
              'Are you sure you want to delete this user? This action cannot be undone.'),
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
                _deleteUser(context, userId);
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

  // Delete User Function
  void _deleteUser(BuildContext context, String userId) {
    FirebaseFirestore.instance.collection('users').doc(userId).delete().then(
      (value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User deleted successfully')),
        );
      },
    ).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete user: $error')),
      );
    });
  }

>>>>>>> 3d0ddc8 (Pembaruan Web)
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
}
<<<<<<< HEAD

Widget _buildUserTable() {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('users').snapshots(),
    builder: (context, snapshot) {
      // Loading State
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      }

      // No Data State
      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
        return Center(child: Text('No users found.'));
      }

      var users = snapshot.data!.docs;

      List<DataRow> rows = users.asMap().entries.map((entry) {
        int index = entry.key;
        QueryDocumentSnapshot user = entry.value;
        var data = user.data() as Map<String, dynamic>;
        String? profilePictureUrl = data['profilePicture'];
        String userId = user.id;

        return DataRow(cells: [
          DataCell(Text('${index + 1}')), // Serial number
          DataCell(Text(data['username'] ?? '')),
          DataCell(Text(data['email'] ?? '')),
          DataCell(Text(data['phoneNumber'] ?? '')),
          DataCell(Text(data['balance']?.toString() ?? '0')),
          DataCell(
            GestureDetector(
              onTap: () {
                _showProfilePictureDialog(context, profilePictureUrl);
              },
              child: profilePictureUrl != null && profilePictureUrl.isNotEmpty
                  ? Image.network(
                      profilePictureUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          _buildPlaceholder(),
                    )
                  : _buildPlaceholder(),
            ),
          ),
          DataCell(
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => _confirmDeleteUser(context, userId),
            ),
          ),
        ]);
      }).toList();

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            columnSpacing: 16, // Adjust spacing if needed
            columns: [
              DataColumn(label: Text('No')), // Serial number header
              DataColumn(label: Text('Username')),
              DataColumn(label: Text('Email')),
              DataColumn(label: Text('Phone Number')),
              DataColumn(label: Text('Balance')),
              DataColumn(label: Text('Profile Picture')),
              DataColumn(label: Text('Actions')),
            ],
            rows: rows,
          ),
        ),
      );
    },
  );
}

// Profile Picture Dialog
void _showProfilePictureDialog(BuildContext context, String? imageUrl) {
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
              imageUrl != null && imageUrl.isNotEmpty
                  ? Image.network(
                      imageUrl,
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.5,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          _buildPlaceholder(),
                    )
                  : _buildPlaceholder(),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('Close'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200], // Button color
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

// Confirmation Dialog for Deletion
void _confirmDeleteUser(BuildContext context, String userId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirm Deletion'),
        content: Text(
            'Are you sure you want to delete this user? This action cannot be undone.'),
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
              _deleteUser(context, userId);
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

// Delete User Function
void _deleteUser(BuildContext context, String userId) {
  FirebaseFirestore.instance.collection('users').doc(userId).delete().then(
    (value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User deleted successfully')),
      );
    },
  ).catchError((error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to delete user: $error')),
    );
  });
}

// Placeholder for Empty Profile Picture
Widget _buildPlaceholder() {
  return Container(
    width: 50,
    height: 50,
    color: Colors.grey[300],
    child: Icon(Icons.person, color: Colors.white),
  );
}
=======
>>>>>>> 3d0ddc8 (Pembaruan Web)
