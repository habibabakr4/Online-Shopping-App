import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:online_shopping_app/providers/cart_provider.dart';
import 'package:online_shopping_app/screens/cart/cart_bottom_checkout.dart';
import 'package:online_shopping_app/screens/cart/cart_widget.dart';
import 'package:online_shopping_app/services/my_app_methods.dart';
import 'package:online_shopping_app/widgets/empty_widget_bag.dart';
import 'package:online_shopping_app/widgets/titles_text.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  final bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return cartProvider.getCartItems.isEmpty
        ? Scaffold(
            body: EmptyBagWidget(
                imagePath:
                    "https://res.cloudinary.com/dueksc1xj/image/upload/v1733704429/shopping_basket_pspoqg.png",
                title: "Your cart is empty",
                subtitle:
                    "Looks like your cart is empty. \nAdd something and make me happy.",
                buttonText: "Shop Now"),
          )
        : Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    MyAppFunctions.showErrorOrWarningDialog(
                      isError: false,
                        context: context,
                        subtitle: "Remove Items",
                        fct: () {
                          cartProvider.clearLocalCart();
                        });
                  },
                  icon: const Icon(
                    IconlyLight.delete,
                    color: Colors.red,
                  ),
                )
              ],
              title: TitlesTextWidget(
                  label: "Cart (${cartProvider.getCartItems.length})"),
              leading: Image.network(
                'https://res.cloudinary.com/dueksc1xj/image/upload/v1733700836/shopping_cart_twbeff.png',
                width: 40,
                height: 40,
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartProvider.getCartItems.length,
                    itemBuilder: (context, index) {
                      return ChangeNotifierProvider.value(
                          value: cartProvider.getCartItems.values
                              .toList()
                              .reversed
                              .toList()[index],
                          child: CartWidget());
                    },
                  ),
                ),
              ],
            ),
            bottomSheet: const CartBottomSheetWidget(),
          );
  }
}
