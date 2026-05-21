import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_app/providers/post_provider.dart';
import 'package:instagram_app/providers/user_provider.dart';
import 'package:instagram_app/screens/login_screen.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => PostProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // primarySwatch: Colors.blue,
          // secondaryHeaderColor: Colors.black,
          // scaffoldBackgroundColor: Colors.yellow,
          // appBarTheme: AppBarTheme(
          //   backgroundColor: Colors.green,
          //   centerTitle: true,
          // ),
        ),
        home: LoginScreen(),
      ),
    );
  }
}
