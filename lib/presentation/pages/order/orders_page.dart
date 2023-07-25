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
            context: context,
            orderNumber: '123456',
            date: '2021-08-01',
            total: 100.0,
            status: 'Delivered',
          ),
          _buildOrderItem(
            context: context,
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
    required BuildContext context,
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
          // show bottom sheet
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Order Details',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Order #123456',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Date: 2021-08-01',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Total: \$100',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Status: Delivered',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Items',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Image.network(
                              'https://healthiersteps.com/wp-content/uploads/2021/12/green-apple-benefits.jpeg',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            title: const Text('Organic Bananas'),
                            subtitle: const Text('Price: \$4.99'),
                            trailing: const Text('Quantity: 1'),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: const Text('View Details'),
      ),
    );
  }
}
