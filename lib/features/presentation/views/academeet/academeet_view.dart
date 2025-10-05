import 'package:flutter/material.dart';

import '../../../../core/theme/theme_data.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/navigation_routes.dart';

class AcadeMeetView extends StatefulWidget {
  const AcadeMeetView({super.key});

  @override
  State<AcadeMeetView> createState() => _AcadeMeetViewState();
}

class _AcadeMeetViewState extends State<AcadeMeetView> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> specialists = [
    {"name": "Ann", "role": "Hair Specialist", "rating": "4.8"},
    {"name": "Sophia", "role": "Hair Specialist", "rating": "4.8"},
    {"name": "Ella", "role": "Hair Specialist", "rating": "4.7"},
  ];

  final List<Map<String, dynamic>> services = [
    {
      "title": "Hair cut",
      "description":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
      "price": "LKR 800.00",
      "image": AppAssets.splashIcon,
    },
    {
      "title": "Make up",
      "description":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
      "price": "LKR 800.00",
      "image": AppAssets.splashIcon,
      "tag": "10% Off",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Blush Heaven",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Salon Specialists",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: "Search specialist or service...",
                          filled: true,
                          fillColor: colors(context).primaryColor500,
                          prefixIcon: Icon(Icons.search, color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: specialists.length,
                    itemBuilder: (context, index) {
                      final spec = specialists[index];
                      return Padding(
                        padding: EdgeInsets.only(left: index == 0 ? 16.0 : 0),
                        child: Container(
                          width: 180,
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: colors(context).primaryColor500,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage(AppAssets.splashIcon),
                                radius: 20,
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(spec["name"],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text(spec["role"],
                                      style: const TextStyle(fontSize: 12)),
                                  Row(
                                    children: [
                                      const Icon(Icons.star,
                                          size: 14, color: Colors.orange),
                                      Text(spec["rating"],
                                          style: const TextStyle(fontSize: 12)),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 36),
                        child: Divider(
                          color: Color(0xB2C4C4C4),
                          thickness: 2,
                        ),
                      ),
                      const Text("Services",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      const SizedBox(height: 12),
                      ListView.builder(
                        itemCount: services.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) =>
                            _serviceCard(services[index]),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _serviceCard(Map<String, dynamic> service) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  service["image"],
                  width: 90,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              if (service.containsKey("tag"))
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(6)),
                    ),
                    child: Text(
                      service["tag"],
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                )
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(service["title"],
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(
                  service["description"],
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 13),
                ),
                const SizedBox(height: 4),
                Text(
                  service["price"],
                  style: TextStyle(
                      color: colors(context).buttonPrimaryColor,
                      fontWeight: FontWeight.bold),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side:
                        BorderSide(color: colors(context).buttonPrimaryColor!),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.kBookAppointmentView);
                  },
                  child: Text("BOOK NOW",
                      style:
                          TextStyle(color: colors(context).buttonPrimaryColor)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
