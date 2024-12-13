import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:online_shopping_app/providers/wishlist_provider.dart';
import 'package:provider/provider.dart';

class HeartButtonWidget extends StatefulWidget {
  const HeartButtonWidget({
    super.key,
    this.colors = Colors.transparent,
    this.size = 20,
    required this.productId,
  });

  final Color colors;
  final double size;
  final String productId;

  @override
  State<HeartButtonWidget> createState() => _HeartButtonWidgetState();
}

class _HeartButtonWidgetState extends State<HeartButtonWidget> {
  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.colors,
      ),
      child: IconButton(
        onPressed: () {
          wishlistProvider.addOrRemoveFromWishlist(productId: widget.productId);
        },
        icon: Icon(
          wishlistProvider.isProdinWishlist(productId: widget.productId)
              ? IconlyBold.heart
              : IconlyLight.heart,
          size: widget.size,
          color: wishlistProvider.isProdinWishlist(productId: widget.productId)
              ? Colors.red
              : Colors.grey,
        ),
      ),
    );
  }
}
