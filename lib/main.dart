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
        apiKey: "AIzaSyAiJ3ynDCCu8uhH_oCU2kNBw3ft-xyCFRk",
        authDomain: "fir-setup-e1481.firebaseapp.com",
        projectId: "fir-setup-e1481",
        storageBucket: "fir-setup-e1481.firebasestorage.app",
        messagingSenderId: "1015895029779",
        appId: "1:1015895029779:web:a9e977aa77dde3c4fae7e6",
      ),
    );
  } else {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyAsnVXGtxr8NcGkwdk48RQeFghPtZ6arZ8",
        projectId: "fir-setup-e1481",
        storageBucket: "fir-setup-e1481.firebasestorage.app",
        messagingSenderId: "1015895029779",
        appId: "1:1015895029779:android:459662868ec0ee65fae7e6",
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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: AuthService.isLoggedIn() ? HomePage() : LoginPage(),
    );
  }
}
