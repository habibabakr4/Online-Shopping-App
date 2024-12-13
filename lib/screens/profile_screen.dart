import 'package:flutter/material.dart';
import 'package:online_shopping_app/providers/theme_provider.dart';
import 'package:online_shopping_app/screens/inner_screens/viewed_recently.dart';
import 'package:online_shopping_app/screens/inner_screens/wishlist_screen.dart';
import 'package:online_shopping_app/widgets/app_name_text.dart';
import 'package:online_shopping_app/widgets/custom_list_title.dart';
import 'package:online_shopping_app/widgets/subtitle_text.dart';
import 'package:online_shopping_app/widgets/titles_text.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title:
            const AppNameTextWidget(), // Added `const` for better performance
        leading: Image.network(
          'https://res.cloudinary.com/dueksc1xj/image/upload/v1733700836/shopping_cart_twbeff.png', // Cloudinary URL
          width: 40, // Width of the image
          height: 40, // Height of the image
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: false,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: TitlesTextWidget(
                label:
                    "Please login to have ultimate", // Fixed unclosed parentheses
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).cardColor,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.surface,
                        width: 3,
                      ),
                      image: const DecorationImage(
                        image: NetworkImage("url"),
                        fit: BoxFit.fill,
                      )),
                ),
                SizedBox(
                  width: 10,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitlesTextWidget(label: "Habiba Bakr"),
                    SubtitleTextWidget(label: "example@gmail.com"),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitlesTextWidget(label: "General"),
                CustomListTitle(
                  icon: Icons.shopping_bag,
                  text: 'All Orders',
                  function: () {},
                ),
                CustomListTitle(
                  icon: Icons.favorite_border,
                  text: 'Wishlist',
                  function: () {
                    Navigator.pushNamed(context, WishlistScreen.routeName);
                  },
                ),
                CustomListTitle(
                  icon: Icons.history,
                  text: 'Viewed recently',
                  function: () {
                    Navigator.pushNamed(context, RecentlyViewedScreen.routeName);
                  },
                ),
                CustomListTitle(
                  icon: Icons.location_on,
                  text: 'Address',
                  function: () {},
                ),
                Divider(
                  thickness: 1,
                ),
                SizedBox(
                  height: 10,
                ),
                TitlesTextWidget(label: "Setttings"),
                SwitchListTile(
                  title: Text(themeProvider.getIsDarkTheme
                      ? "Dark Mode"
                      : "Light Mode"),
                  value: themeProvider.getIsDarkTheme,
                  onChanged: (value) {
                    themeProvider.setDarkTheme(themevalue: value);
                  },
                ),
                Divider(
                  thickness: 1,
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.login),
                    label: const Text("Login"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
