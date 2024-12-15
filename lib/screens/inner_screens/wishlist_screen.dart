import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping_app/providers/wishlist_provider.dart';
import 'package:online_shopping_app/services/my_app_methods.dart';
import 'package:online_shopping_app/widgets/app_name_text.dart';
import 'package:online_shopping_app/widgets/empty_widget_bag.dart';
import 'package:online_shopping_app/widgets/products/products_widget.dart';
import 'package:online_shopping_app/widgets/titles_text.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = "/WishlistScreen";
  final bool isEmpty = false;
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    return wishlistProvider.getWishlists.isEmpty
        ? Scaffold(
          appBar: AppBar(
        title: const AppNameTextWidget(
          fontSize: 20,
        ),
        leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                Navigator.canPop(context) ? Navigator.pop(context) : null;
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 18,
              ),
            ) 
            ),
      ),
            body: EmptyBagWidget(
              imagePath:
                  "https://res.cloudinary.com/dueksc1xj/image/upload/v1733927353/bag_wish_annlw5.png",
              title: "Your  Wishlist is empty",
              subtitle:
                  "Looks like you add didn’t add anything yet to your cart \n ",
              buttonText: "Shop now",
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: TitlesTextWidget(
                  label:
                      "Wishlist(${wishlistProvider.getWishlists.length})"), // Improved with `const`
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  'https://res.cloudinary.com/dueksc1xj/image/upload/v1733700836/shopping_cart_twbeff.png',
                  width: 40,
                  height: 40,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    MyAppFunctions.showErrorOrWarningDialog(
                      isError: false,
                        context: context,
                        subtitle: "Remove items?",
                        fct: () {
                          wishlistProvider.clearLocalWishlist();
                        });
                  },
                  icon: const Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.red,
                  ),
                )
              ],
            ),
            body: DynamicHeightGridView(
              itemCount: wishlistProvider.getWishlists.length,
              builder: (context, index) {
                return ProductsWidget(
                  productId: wishlistProvider.getWishlists.values
                      .toList()[index]
                      .productId,
                );
              },
              crossAxisCount: 2,
            ),
          );
  }
}
