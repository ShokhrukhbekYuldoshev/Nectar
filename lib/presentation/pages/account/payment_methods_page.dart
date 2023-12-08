import 'package:flutter/material.dart';

class PaymentMethodsPage extends StatefulWidget {
  const PaymentMethodsPage({super.key});

  @override
  State<PaymentMethodsPage> createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  int _selectedPaymentMethodIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Methods'),
      ),
      body: ListView(
        children: [
          _buildPaymentMethodItem(
            icon: Icons.credit_card,
            title: 'Credit Card',
            subtitle: '**** **** **** 1234',
            isSelected: _selectedPaymentMethodIndex == 0,
            onTap: () {
              setState(() {
                _selectedPaymentMethodIndex = 0;
              });
            },
          ),
          _buildPaymentMethodItem(
            icon: Icons.payment,
            title: 'PayPal',
            subtitle: 'example@example.com',
            isSelected: _selectedPaymentMethodIndex == 1,
            onTap: () {
              setState(() {
                _selectedPaymentMethodIndex = 1;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: isSelected ? const Icon(Icons.check) : null,
      onTap: onTap,
    );
  }
}
