import 'package:flutter/material.dart';

import '../../../../core/theme/theme_data.dart';
import '../../../../utils/app_enum.dart';
import '../../../../utils/app_styling.dart';
import '../../../../utils/navigation_routes.dart';


class PaymentView extends StatefulWidget {
  const PaymentView({super.key});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  PaymentMethod? _paymentMethod = PaymentMethod.Full;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Payment'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSection(
              icon: Icons.cut,
              title: 'Blush Heaven',
              subtitle: 'Lorem ipsum dolor sit am...',
              trailing: 'Change',
            ),
            const SizedBox(height: 12),
            _buildBookingInfo(),
            const SizedBox(height: 12),
            _buildPaymentType(),
            const SizedBox(height: 12),
            _buildPriceDetails(),
            const SizedBox(height: 12),
            _buildCardInfo(),
            SizedBox(height: 84),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.kBookingSuccessView,
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: colors(context).buttonPrimaryColor!
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 32),
                  child: Center(
                    child: Text(
                      "CONFIRM PAYMENT",
                      style: AppStyling.boldTextSize16.copyWith(
                        color: colors(context).whiteColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required IconData icon,
    required String title,
    required String subtitle,
    required String trailing,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: colors(context).primaryColor500!,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: const TextStyle(color: Colors.grey, fontSize: 14)),
              ],
            ),
          ),
          Text(trailing,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildBookingInfo() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: colors(context).primaryColor500!,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Booking",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text("Hair cut"),
                SizedBox(height: 8),
                Text("Maria"),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text("04/06/2025"),
              Text("02:30 PM"),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildPaymentType() {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Radio(
                value: PaymentMethod.Full,
                groupValue: _paymentMethod,
                onChanged: (_) {
                  setState(() {
                    _paymentMethod = PaymentMethod.Full;
                  });
                },
                activeColor: colors(context).primaryColor800!
              ),
              const Text('Full Payment'),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Radio(
                  value: PaymentMethod.Advance,
                  groupValue: _paymentMethod,
                  activeColor: colors(context).primaryColor800!,
                  onChanged: (_) {
                    setState(() {
                      _paymentMethod = PaymentMethod.Advance;
                    });
                  }),
              const Text('Advance Payment'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPriceDetails() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: const [
          _PriceRow(label: 'Discount', value: '00.00'),
          _PriceRow(label: 'Sub Total (LKR)', value: '800.00'),
          Divider(),
          _PriceRow(
            label: 'Total (LKR)',
            value: '800.00',
            isBold: true,
          ),
        ],
      ),
    );
  }

  Widget _buildCardInfo() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.credit_card, color: colors(context).primaryColor800!),
          SizedBox(width: 12),
          Expanded(
            child: Text("**** **** **** 1234", style: TextStyle(fontSize: 16)),
          ),
          Text(
            "Change",
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const _PriceRow({
    required this.label,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = isBold
        ? const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
        : const TextStyle(fontSize: 14);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label, style: style), Text(value, style: style)],
      ),
    );
  }
}
