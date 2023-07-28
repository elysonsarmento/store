import 'package:flutter/material.dart';

import '../domain/entity/product.entity.dart';

class CardProduct extends StatelessWidget {
  const CardProduct({
    super.key,
    required this.product,
    this.onLikeTap,
  });

  final Product product;
  final VoidCallback? onLikeTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Center(child: Image.network(product.image)),
          ),
          const SizedBox(
            width: 30,
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: const TextStyle(
                    color: Color(0xFF37474F),
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.60,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Color(0xFFFFD700),
                        ),
                        Text(
                          product.rating.toString(),
                          style: const TextStyle(
                            color: Color(0xA537474F),
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "(${product.totalRating.toInt()})",
                          style: const TextStyle(
                            color: Color(0xA537474F),
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    onLikeTap != null
                        ? GestureDetector(
                            onTap: () {
                              onLikeTap?.call();
                            },
                            child: Icon(
                              product.isFavorite == true
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: product.isFavorite == true
                                  ? const Color(0xFFFF0000)
                                  : const Color(0xFF37474F),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "\$${product.price.toString()}",
                  style: const TextStyle(
                    color: Color(0xFFF37A20),
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
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
