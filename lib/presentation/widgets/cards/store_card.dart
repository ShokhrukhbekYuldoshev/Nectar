import 'package:flutter/material.dart';
import 'package:nectar/data/models/store.dart';
import 'package:nectar/presentation/utils/helpers.dart';

class StoreCard extends StatelessWidget {
  final Store store;

  const StoreCard({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color randomColor = generateRandomColor();

    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        color: randomColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          // image or icon
          if (store.image != null)
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                image: DecorationImage(
                  image: AssetImage(store.image!),
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
          Text(
            store.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
