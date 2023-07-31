import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nectar/presentation/utils/app_router.dart';
import 'package:nectar/presentation/utils/helpers.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String imageUrl;

  const CategoryCard({
    super.key,
    required this.title,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final Color randomColor = generateRandomColor();

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRouter.productsRoute, arguments: title);
      },
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.only(
          top: 25,
          left: 15,
          right: 15,
          bottom: 15,
        ),
        width: 170,
        height: 200,
        decoration: BoxDecoration(
          color: randomColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: randomColor,
          ),
        ),
        child: Column(
          children: [
            // image
            CachedNetworkImage(
              imageUrl: imageUrl,
              height: 90,
            ),
            const SizedBox(height: 20),
            // title
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
