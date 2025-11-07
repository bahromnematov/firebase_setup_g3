import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_setup_g3/home_page.dart';
import 'package:firebase_setup_g3/login_page.dart';
import 'package:firebase_setup_g3/service/auth_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyDOMIs2dT2L_ijqwXkbR2MiWIVu3NSM1AU",
        authDomain: "mevazor-mfy.firebaseapp.com",
        databaseURL: "https://mevazor-mfy-default-rtdb.firebaseio.com",
        projectId: "mevazor-mfy",
        storageBucket: "mevazor-mfy.firebasestorage.app",
        messagingSenderId: "552857989782",
        appId: "1:552857989782:web:afce6184a742a6f03448b7",
      ),
    );
  } else {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyDoC4UNyAWr1Em-bOe5A9qoA8i9L-3hu3g",
        projectId: "mevazor-mfy",
        storageBucket: "mevazor-mfy.firebasestorage.app",
        messagingSenderId: "1015895029779",
        appId: "1:552857989782:android:146286ec5497e9593448b7",
      ),
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: AuthService.isLoggedIn() ? HomePage() : LoginPage(),
    );
  }
}
