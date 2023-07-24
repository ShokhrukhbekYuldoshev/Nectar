import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nectar/presentation/utils/app_colors.dart';
import 'package:nectar/presentation/widgets/buttons/round_button.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

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
          // image
          CachedNetworkImage(
            imageUrl:
                'https://cdn.viva.org.uk/wp-content/uploads/2020/02/Bananas.jpg',
            height: 100,
          ),
          const SizedBox(height: 20),
          // title
          Text(
            'Banana',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          // unit
          Text(
            '1kg, Price',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // price
              Text(
                '\$4.99',
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
