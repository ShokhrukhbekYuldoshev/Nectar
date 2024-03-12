import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nectar/src/data/models/store.dart';
import 'package:nectar/src/presentation/utils/extensions.dart';
import 'package:nectar/src/presentation/utils/helpers.dart';

class StoreCard extends StatefulWidget {
  final Store store;

  const StoreCard({
    super.key,
    required this.store,
  });

  @override
  State<StoreCard> createState() => _StoreCardState();
}

class _StoreCardState extends State<StoreCard> {
  final Color randomColor = generateRandomColor().darken();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        Navigator.pushNamed(
          context,
          '/store-details',
          arguments: widget.store,
        );
      },
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          color: randomColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            // image or icon
            if (widget.store.image != null && widget.store.image!.isNotEmpty)
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      widget.store.image!,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            else
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: randomColor,
                ),
                child: const Center(
                  child: Icon(
                    Icons.store,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                widget.store.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
