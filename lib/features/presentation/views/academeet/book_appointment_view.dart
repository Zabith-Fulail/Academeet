import 'package:flutter/material.dart';

import '../../../../core/theme/theme_data.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/navigation_routes.dart';

class BookAppointmentView extends StatelessWidget {
  final List<Map<String, String>> experts = [
    {
      'name': 'Ann',
      'role': 'Hair Specialist',
      'rating': '4.8',
      'image': AppAssets.splashIcon,
    },
    {
      'name': 'Tina',
      'role': 'Hair Specialist',
      'rating': '4.8',
      'image': AppAssets.splashIcon,
    },
    {
      'name': 'Nora',
      'role': 'Hair Specialist',
      'rating': '4.8',
      'image': AppAssets.splashIcon,
    },
    {
      'name': 'Alice',
      'role': 'Hair Specialist',
      'rating': '4.8',
      'image': AppAssets.splashIcon,
    },
    {
      'name': 'Jane',
      'role': 'Hair Specialist',
      'rating': '4.8',
      'image': AppAssets.splashIcon,
    },
    {
      'name': 'Lisa',
      'role': 'Hair Specialist',
      'rating': '4.8',
      'image': AppAssets.splashIcon,
    },
  ];

  BookAppointmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Book Appointment"),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Select Experts",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                itemCount: experts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.68,
                ),
                itemBuilder: (context, index) {
                  final expert = experts[index];
                  return _buildExpertCard(context, expert);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpertCard(BuildContext context, Map<String, String> expert) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors(context).primaryColor500,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(expert['image']!),
            radius: 32,
          ),
          const SizedBox(height: 8),
          Text(expert['name']!,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(expert['role']!, style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star, color: Colors.orange, size: 16),
              const SizedBox(width: 4),
              Text(expert['rating']!, style: const TextStyle(fontSize: 12)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "Lorem ipsum dolor sit amet consectetur. Donec vestibulum fringilla.",
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
          const Spacer(),
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, Routes.kBookingDateTimeView);
            },
            child: Container(
              decoration: BoxDecoration(
                color: colors(context).primaryColor500,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colors(context).buttonPrimaryColor!),
              ),
              // width: 64,
              // height: 24,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                "Select",
                style: TextStyle(color: colors(context).buttonPrimaryColor!, fontSize: 12),
              ),
            ),
          ),
          // ElevatedButton(
          //   onPressed: () {},
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: Colors.white,
          //     foregroundColor: Colors.pink,
          //     side: const BorderSide(color: Colors.pink),
          //     padding: const EdgeInsets.symmetric(horizontal: 16),
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(8),
          //     ),
          //     textStyle: const TextStyle(fontWeight: FontWeight.bold),
          //   ),
          //   child: const Text("Select"),
          // ),
        ],
      ),
    );
  }
}
