import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping_app/models/product_model.dart';
import 'package:online_shopping_app/providers/viewed_recently_provider.dart';
import 'package:online_shopping_app/screens/inner_screens/products_details.dart';
import 'package:online_shopping_app/widgets/products/heart_btn.dart';
import 'package:online_shopping_app/widgets/subtitle_text.dart';
import 'package:provider/provider.dart';

class LatestArrivalProductWidget extends StatelessWidget {
  const LatestArrivalProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<ProductModel>(context);
    Size size = MediaQuery.of(context).size;
    final viewedProvider = Provider.of<ViewedProdProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          viewedProvider.addViewedProd(productId: productModel.productId);
          Navigator.pushNamed(
            context,
            ProductDetails.routName,
            arguments: productModel.productId,
          );
        },
        child: SizedBox(
          width: size.width * 0.45,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: FancyShimmerImage(
                    imageUrl: productModel.productImage,
                    width: size.width * 0.28,
                    height: size.height * 0.28,
                  ),
                ),
              ),
              const SizedBox(
                width: 7,
              ),
              Flexible(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productModel.productTitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  FittedBox(
                    child: Row(
                      children: [
                        HeartButtonWidget(
                          productId: productModel.productId,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.add_shopping_cart_rounded,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  FittedBox(
                    child: SubtitleTextWidget(
                      label: "${productModel.productPrice}\$",
                      color: Colors.blue,
                    ),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
