import 'package:flutter/material.dart';
import 'package:productos_app/services/services.dart';
import 'package:provider/provider.dart';

import 'screens/screens.dart';

void main() => runApp(const AppState());

  class AppState extends StatelessWidget {
  const AppState({super.key});

 

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:  [
        ChangeNotifierProvider(create: (_) => ProductsService(),),
        ChangeNotifierProvider(create: (_) => AuthService(),),
      ],
      child: const MyApp(),
    
    
    );
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Productos App',
      initialRoute: 'login',
      routes: {
        'login' : (_) => const LoginScreen(),
        'register' : (_) => const RegisterScreen(),
        'home' : (_) => const HomeScreen(),
        'product' : (_) => const ProductScreen(),
        'checking' : (_) => const CheckAuthScreen(),
      },
      scaffoldMessengerKey: NotificationsService.messengerKey,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300],
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colors.indigo,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.indigo,
          elevation: 0
        )
      ),
    );

  }
}