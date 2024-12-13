import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping_app/providers/cart_provider.dart';
import 'package:online_shopping_app/providers/products_provider.dart';
import 'package:online_shopping_app/screens/inner_screens/products_details.dart';
import 'package:online_shopping_app/widgets/products/heart_btn.dart';
import 'package:online_shopping_app/widgets/subtitle_text.dart';
import 'package:online_shopping_app/widgets/titles_text.dart';
import 'package:provider/provider.dart';

class ProductsWidget extends StatefulWidget {
  final String productId;
  const ProductsWidget({super.key, required this.productId});

  @override
  State<ProductsWidget> createState() => _ProductsWidgetState();
}

class _ProductsWidgetState extends State<ProductsWidget> {
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductProvider>(context);
    final getCurrentProduct = productsProvider.findByProdId(widget.productId);
    final cartProvider = Provider.of<CartProvider>(context);
    Size size = MediaQuery.of(context).size;
    return getCurrentProduct == null
        ? SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () async {
                await Navigator.pushNamed(
                  context,
                  ProductDetails.routName,
                  arguments: getCurrentProduct.productId,
                );
              },
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: FancyShimmerImage(
                      imageUrl: getCurrentProduct.productImage,
                      height: size.height * 0.22,
                      width: double.infinity,
                    ),
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 5,
                        child: TitlesTextWidget(
                          label: getCurrentProduct.productTitle,
                          maxLines: 2,
                          fontSize: 10,
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: HeartButtonWidget(
                          productId: getCurrentProduct.productId,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: SubtitleTextWidget(
                              label: "${getCurrentProduct.productPrice}\$"),
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(16.0),
                          color: Colors.lightBlue,
                          child: InkWell(
                            splashColor: Colors.red,
                            borderRadius: BorderRadius.circular(16.0),
                            onTap: () {
                              if (cartProvider.isProductInCart(
                                  productId: getCurrentProduct.productId)) {
                                return;
                              }
                              cartProvider.addProductToCart(
                                  productId: getCurrentProduct.productId);
                            },
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                cartProvider.isProductInCart(
                                        productId: getCurrentProduct.productId)
                                    ? Icons.check
                                    : Icons.add_shopping_cart_outlined,
                                size: 20,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
