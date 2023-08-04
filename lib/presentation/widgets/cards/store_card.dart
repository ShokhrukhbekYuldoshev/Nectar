import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nectar/data/models/store.dart';
import 'package:nectar/presentation/utils/extensions.dart';
import 'package:nectar/presentation/utils/helpers.dart';

class StoreCard extends StatelessWidget {
  final Store store;

  const StoreCard({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color randomColor = generateRandomColor().darken();

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        Navigator.pushNamed(
          context,
          '/store-details',
          arguments: store,
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
            if (store.image != null && store.image!.isNotEmpty)
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      store.image!,
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
                store.name,
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
