import 'package:flutter/material.dart';

class PromoCodesPage extends StatelessWidget {
  const PromoCodesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Promo Codes'),
      ),
      body: ListView(
        children: [
          _buildPromoCodeItem(
            code: 'SUMMER2023',
            description: 'Get 10% off your order',
            expiryDate: 'Expires on 31 Aug 2023',
          ),
          _buildPromoCodeItem(
            code: 'FREESHIP',
            description: 'Free shipping on orders over \$50',
            expiryDate: 'Expires on 15 Sep 2023',
          ),
          _buildPromoCodeItem(
            code: 'SALE20',
            description: 'Get 20% off your order',
            expiryDate: 'Expires on 30 Sep 2023',
          ),
        ],
      ),
    );
  }

  Widget _buildPromoCodeItem({
    required String code,
    required String description,
    required String expiryDate,
  }) {
    return ListTile(
      title: Text(
        code,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(description),
          Text(
            expiryDate,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
      trailing: ElevatedButton(
        onPressed: () {
          // TODO: Implement promo code redemption logic
        },
        child: const Text('Redeem'),
      ),
    );
  }
}
