import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping_app/providers/cart_provider.dart';
import 'package:online_shopping_app/providers/products_provider.dart';
import 'package:online_shopping_app/widgets/app_name_text.dart';
import 'package:online_shopping_app/widgets/products/heart_btn.dart';
import 'package:online_shopping_app/widgets/subtitle_text.dart';
import 'package:online_shopping_app/widgets/titles_text.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  static const routName = "/ProductDetails";
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productProvider = Provider.of<ProductProvider>(context, listen: false);
    String? productId = ModalRoute.of(context)!.settings.arguments as String?;
    final getCurrentProduct = productProvider.findByProdId(productId!);
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            FancyShimmerImage(
              imageUrl: getCurrentProduct!.productImage,
              height: size.height * 0.38,
              width: double.infinity,
              boxFit: BoxFit.contain,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          getCurrentProduct.productTitle,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SubtitleTextWidget(
                        label: "${getCurrentProduct.productPrice}\$",
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HeartButtonWidget(
                          productId: getCurrentProduct.productId,
                          colors: Colors.blue.shade300,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: kBottomNavigationBarHeight - 10,
                            child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.lightBlue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                onPressed: () {
                                  if(cartProvider.isProductInCart(
                                    productId: getCurrentProduct.productId)){
                                      return;

                                  }
                                  cartProvider.addProductToCart(
                                    productId: getCurrentProduct.productId);
                                },
                                icon: Icon(
                                      cartProvider.isProductInCart(
                                              productId:
                                                  getCurrentProduct.productId)
                                          ? Icons.check
                                          : Icons.add_shopping_cart_outlined,
                                    ),
                                    label: Text(cartProvider.isProductInCart(
                                            productId: getCurrentProduct.productId)
                                        ? "In cart"
                                        : "Add to cart"),
                                  ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TitlesTextWidget(label: "About this item"),
                      SubtitleTextWidget(
                        label: getCurrentProduct.productCategory),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SubtitleTextWidget(
                    label: getCurrentProduct.productDescription),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
