import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nectar/data/models/category.dart';
import 'package:nectar/presentation/utils/app_router.dart';
import 'package:nectar/presentation/utils/extensions.dart';
import 'package:nectar/presentation/utils/helpers.dart';

class CategoryCard extends StatefulWidget {
  final Category category;

  const CategoryCard({
    super.key,
    required this.category,
  });

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  final Color randomColor = generateRandomColor().darken();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRouter.categoryProductsRoute,
          arguments: widget.category,
        );
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
            widget.category.image != null && widget.category.image!.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: widget.category.image!,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover,
                    height: 90,
                  )
                : const Icon(Icons.category, size: 90, color: Colors.grey),
            const SizedBox(height: 20),
            // title
            Expanded(
              child: Text(
                widget.category.name,
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
