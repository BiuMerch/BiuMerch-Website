import 'dart:io';

import 'package:apa/Toko_page.dart';
import 'package:apa/login_page.dart';
import 'package:apa/main.dart';
import 'package:apa/pemesanan.dart';
import 'package:apa/tarik_dana.dart';
import 'package:apa/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:apa/produk_page.dart';
import 'package:image_picker/image_picker.dart';
<<<<<<< HEAD
=======
import 'package:shared_preferences/shared_preferences.dart';
>>>>>>> 3d0ddc8 (Pembaruan Web)
import 'banner_page.dart';
import 'kategori_page.dart';
import 'Admin_page.dart';

class BannerPage extends StatefulWidget {



  @override
  _BannerPageState createState() => _BannerPageState();
}

class _BannerPageState extends State<BannerPage> {
  // Track the selected menu item
  String _selectedMenu = 'Banner';
  File? _imageFile;
  String? _imageUrl;
  final ImagePicker _picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _imageUrl = pickedFile.path; // For web
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_imageFile == null && _imageUrl == null) return;

    try {
      String fileName = _imageFile != null
          ? _imageFile!.path.split('/').last
          : _imageUrl!.split('/').last;

      // Ensure fileName has an extension
      if (!fileName.contains('.')) {
        fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg'; // Default to a timestamp if extension is missing
      }

      Reference storageRef = _storage.ref().child('banners/$fileName');
      UploadTask uploadTask;

      if (!kIsWeb) {
        uploadTask = storageRef.putFile(
          _imageFile!,
          SettableMetadata(contentType: 'image/jpeg'), // Set content type
        );
      } else {
        uploadTask = storageRef.putData(
          await XFile(_imageUrl!).readAsBytes(),
          SettableMetadata(contentType: 'image/jpeg'), // Set content type
        );
      }

      await uploadTask.whenComplete(() async {
        String downloadUrl = await storageRef.getDownloadURL();
        print('Download URL: $downloadUrl');

        // Save the download URL to Firestore
        await _firestore.collection('banners').add({
          'imageUrl': downloadUrl,
          'createdAt': FieldValue.serverTimestamp(),
        });

        setState(() {
          _imageFile = null;
          _imageUrl = null;
        });

        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Banner uploaded successfully!')),
        );
      });
    } catch (e) {
      print('Failed to upload image: $e');
      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload banner. Please try again.')),
      );
    }
  }




  Future<void> _deleteImage(String imageUrl) async {
  try {
    // Delete from Firebase Storage
    Reference imageRef = _storage.refFromURL(imageUrl);
    await imageRef.delete();

    // Delete from Firestore
    QuerySnapshot querySnapshot = await _firestore
        .collection('banners')
        .where('imageUrl', isEqualTo: imageUrl)
        .get();

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      await doc.reference.delete();
    }

    print('Image deleted successfully from Storage and Firestore');

    // Refresh the UI
    setState(() {});

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Banner deleted successfully!')),
    );
  } catch (e) {
    print('Failed to delete image: $e');
    // Show error message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to delete banner. Please try again.')),
    );
  }
}
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
                        'kategori',
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
                          setState(() {
                            _selectedMenu = 'Banner';
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
                        'Banner',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: _imageFile == null && _imageUrl == null
                                  ? Center(
                                      child: Icon(Icons.image,
                                          size: 50, color: Colors.grey[600]),
                                    )
                                  : !kIsWeb
                                      ? Image.file(_imageFile!)
                                      : Image.network(
                                          _imageUrl!,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Center(
                                              child: Icon(Icons.error,
                                                  color: Colors.red, size: 50),
                                            );
                                          },
                                        ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ElevatedButton(
                                  onPressed: _pickImage,
                                  child: Text('Upload Foto',
                                      style: TextStyle(color: Colors.white)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey[400],
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 8),
                                ElevatedButton(
                                  onPressed: _uploadImage,
                                  child: Text('Simpan',
                                      style: TextStyle(color: Colors.white)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green[700],
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      Expanded(
                          child: FutureBuilder<ListResult>(
                        future: _storage.ref('banners').listAll(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          }
                          if (!snapshot.hasData ||
                              snapshot.data!.items.isEmpty) {
                            return Center(child: Text('No images available'));
                          }
                          List<Reference> items = snapshot.data!.items;

                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 2,
                            ),
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              return FutureBuilder<String>(
                                future: items[index].getDownloadURL(),
                                builder: (context, urlSnapshot) {
                                  if (urlSnapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }
                                  if (urlSnapshot.hasError) {
                                    print(
                                        'Error loading image: ${urlSnapshot.error}');
                                    return Center(
                                      child: Icon(Icons.error,
                                          color: Colors.red, size: 50),
                                    );
                                  }
                                  if (!urlSnapshot.hasData) {
                                    return Center(child: Text('No image URL'));
                                  }
                                  String imageUrl = urlSnapshot.data!;
                                  return Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                            image: NetworkImage(imageUrl),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          right: 8,
                                          top: 8,
                                          child: IconButton(
                                            icon: Icon(Icons.delete,
                                                color: Colors.red),
                                            onPressed: () async {
                                              bool? confirmDelete =
                                                  await showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                  title: Text('Delete Image'),
                                                  content: Text(
                                                      'Are you sure you want to delete this image?'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.of(context)
                                                              .pop(false),
                                                      child: Text('Cancel'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.of(context)
                                                              .pop(true),
                                                      child: Text('Delete'),
                                                    ),
                                                  ],
                                                ),
                                              );

                                              if (confirmDelete == true) {
                                                await _deleteImage(imageUrl);
                                                setState(() {
                                                  // Refresh GridView
                                                });
                                              }
                                            },
                                          )),
                                    ],
                                  );
                                },
                              );
                            },
                          );
                        },
                      )),
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
                _selectedMenu = title;
              });
            },
            child: Container(
              color: isSelected || isHovering
                  ? Colors.grey[300]
                  : Colors.transparent,
              child: ListTile(
                leading: Icon(icon,
                    color: isSelected || isHovering
                        ? Colors.green[700]
                        : Colors.black),
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
