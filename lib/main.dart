import 'package:apa/login_page.dart';
import 'package:apa/produk_page.dart';
import 'package:apa/test_firebase.dart';
import 'package:flutter/material.dart';
import 'package:apa/produk_page.dart';
import 'banner_page.dart';
import 'kategori_page.dart';
import 'Admin_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BIU Merch Admin',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}

