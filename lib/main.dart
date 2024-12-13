import 'package:flutter/material.dart';
import 'package:online_shopping_app/consts/theme_data.dart';
import 'package:online_shopping_app/providers/cart_provider.dart';
import 'package:online_shopping_app/providers/products_provider.dart';
import 'package:online_shopping_app/providers/theme_provider.dart';
import 'package:online_shopping_app/providers/viewed_recently_provider.dart';
import 'package:online_shopping_app/providers/wishlist_provider.dart';
import 'package:online_shopping_app/root_screen.dart';
import 'package:online_shopping_app/screens/auth/forget_password.dart';
import 'package:online_shopping_app/screens/auth/login.dart';
import 'package:online_shopping_app/screens/auth/register.dart';
import 'package:online_shopping_app/screens/inner_screens/products_details.dart';
import 'package:online_shopping_app/screens/inner_screens/viewed_recently.dart';
import 'package:online_shopping_app/screens/inner_screens/wishlist_screen.dart';
import 'package:online_shopping_app/screens/search_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WishlistProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ViewedProdProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (
          context, 
          themeProvider,
          child
        ){
          return MaterialApp(
            title: 'Online Shop',
            theme: Styles.themeData(
                isDarkTheme: themeProvider.getIsDarkTheme, context: context),
            home: const RootScreen(),
            routes: {
              ProductDetails.routName: (context) => const ProductDetails(),
              WishlistScreen.routeName: (context) => const WishlistScreen(),
              RecentlyViewedScreen.routeName: (context) => const RecentlyViewedScreen(),
              RegisterScreen.routName: (context) => const RegisterScreen(),
              LoginScreen.routeName: (context) => const LoginScreen(),
              ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
              SearchScreen.routeName: (context) => const SearchScreen(),
            },
          );
        }
      ),
    );
  }
}
