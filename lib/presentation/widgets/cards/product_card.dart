import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nectar/data/models/product.dart';
import 'package:nectar/presentation/utils/app_colors.dart';
import 'package:nectar/presentation/widgets/buttons/round_button.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 20,
        left: 15,
        right: 15,
        bottom: 15,
      ),
      width: 170,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.lightBorderGray,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // image or icon
          if (product.images != null && product.images!.isNotEmpty)
            CachedNetworkImage(
              imageUrl: product.images!.first,
              height: 100,
              fit: BoxFit.cover,
            )
          else
            const Icon(
              Icons.inventory,
              size: 100,
              color: AppColors.primary,
            ),
          const SizedBox(height: 20),
          // title
          Text(
            product.name,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          // unit
          Text(
            "1 ${product.unit.name}",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // price
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              // add to cart
              RoundButton(
                icon: Icons.add,
                onTap: () {},
              )
            ],
          )
        ],
      ),
    );
  }
}
