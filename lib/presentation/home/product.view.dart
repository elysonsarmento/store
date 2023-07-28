import 'package:flutter/material.dart';

import '../../domain/entity/product.entity.dart';

class ProductView extends StatelessWidget {
  final Product product;
  const ProductView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              'Product Detail',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            //like
            actions: [
              product.isFavorite == true
                  ? const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )
                  : const Icon(Icons.favorite_border),
            ]),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 18,
          ),
          child: Column(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  product.image,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                product.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
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
                  Text(
                    "\$${product.price}",
                    style: const TextStyle(
                      color: Color(0xFF5EC401),
                      fontSize: 30,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Icon(
                    Icons.sort,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "${product.category.displayName}",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF3E3E3E),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.menu,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        "${product.description}",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF3E3E3E),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
