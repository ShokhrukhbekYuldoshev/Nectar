import 'package:flutter/material.dart';

// TODO: Implement OrdersPage

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: ListView(
        children: [
          _buildOrderItem(
            orderNumber: '123456',
            date: '2021-08-01',
            total: 100.0,
            status: 'Delivered',
          ),
          _buildOrderItem(
            orderNumber: '789012',
            date: '2021-08-15',
            total: 50.0,
            status: 'In Transit',
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem({
    required String orderNumber,
    required String date,
    required double total,
    required String status,
  }) {
    return ListTile(
      title: Text('Order #$orderNumber'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Date: $date'),
          Text('Total: \$$total'),
          Text('Status: $status'),
        ],
      ),
      trailing: ElevatedButton(
        onPressed: () {
          // TODO: Implement order details page navigation
        },
        child: const Text('View Details'),
      ),
    );
  }
}
