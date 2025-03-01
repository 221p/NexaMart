import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/wishlist_provider.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class HeartBtnWidget extends StatefulWidget {
  final double size;
  final Color colors;
  final String productId;

  const HeartBtnWidget(
      {super.key,
      this.size = 22,
      this.colors = Colors.transparent,
      required this.productId});

  @override
  State<HeartBtnWidget> createState() => _HeartBtnWidgetState();
}

class _HeartBtnWidgetState extends State<HeartBtnWidget> {
  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.colors,
      ),
      child: IconButton(
        style: IconButton.styleFrom(
          shape: CircleBorder(),
        ),
        onPressed: () {
          wishlistProvider.addOrRemoveFromWishlist(productId: widget.productId);
        },
        icon: Icon(
          wishlistProvider.isProductInWishlist(productId: widget.productId)
          ? IconlyBold.heart 
          :IconlyLight.heart,
          size: widget.size,
          color: wishlistProvider.isProductInWishlist(productId: widget.productId) 
          ? Colors.redAccent
          : Colors.grey,
        ),
      ),
    );
  }
}
