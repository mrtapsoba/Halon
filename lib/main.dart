import 'package:decouvrir/controllers/auth_controller.dart';
import 'package:decouvrir/models/constantes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/home_page.dart';
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
    return StreamProvider<AppUser?>.value(
        value: AuthController().user,
        initialData: null,
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: Constantes().appName,
            theme: ThemeData(
              colorScheme:
                  ColorScheme.fromSeed(seedColor: Constantes().mainColor),
              useMaterial3: true,
            ),
            home: const HomePage()));
  }
}
