import 'package:flutter/material.dart';

import '../../../../core/theme/theme_data.dart';

class BookingSuccessView extends StatelessWidget {
  const BookingSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            children: [
              const SizedBox(height: 48),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.check_circle, size: 48, color: Colors.black87),
                    const SizedBox(height: 12),
                    const Text(
                      'Your Appointment\nBooking Successfully!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Divider(thickness: 1, color: Colors.grey),
                    const SizedBox(height: 16),
                    _buildRow("Booking ID", "114"),
                    _buildRow("Salon Name", "Blush Heaven"),
                    _buildRow("Service", "Hair cut"),
                    _buildRow("Expert", "Maria"),
                    _buildRow("Date", "04/06/2025", isBold: true),
                    _buildRow("Time", "02:30 PM"),
                    _buildRow("Payment Status", "Completed"),
                    _buildRow("Balance (LKR)", "00.00", isBold: true),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    // download receipt logic
                  },
                  icon: Icon(Icons.download, color: colors(context).buttonPrimaryColor),
                  label:  Text(
                    "Download Receipt",
                    style: TextStyle(color: colors(context).buttonPrimaryColor),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: colors(context).buttonPrimaryColor!),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isBold = false}) {
    final textStyle = TextStyle(
      fontSize: 14,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: textStyle),
          Text(value, style: textStyle),
        ],
      ),
    );
  }
}
