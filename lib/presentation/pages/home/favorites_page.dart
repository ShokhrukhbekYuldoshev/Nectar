import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nectar/data/models/product.dart';
import 'package:nectar/data/models/unit.dart';
import 'package:nectar/presentation/utils/app_colors.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Favorites',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(
              color: AppColors.lightBorderGray,
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return const FavoriteItem(
                  product: Product(
                    name: 'Organic Bananas',
                    price: 4.99,
                    unit: Unit(symbol: 'kg', name: 'kilogram'),
                    images: [
                      'https://healthiersteps.com/wp-content/uploads/2021/12/green-apple-benefits.jpeg',
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Divider(
                    color: AppColors.lightBorderGray,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FavoriteItem extends StatelessWidget {
  final Product product;

  const FavoriteItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 30,
      ),
      child: Row(
        children: [
          // image
          product.images!.isEmpty
              ? Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.gray,
                  ),
                )
              : Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        product.images!.first,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
          const SizedBox(width: 25),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // unit
                Text(
                  '1 ${product.unit.symbol}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.lightGray,
                  ),
                ),
              ],
            ),
          ),
          // price
          Text(
            '\$${product.price}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          // open product
          const SizedBox(width: 10),
          const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: AppColors.lightGray,
          ),
        ],
      ),
    );
  }
}
