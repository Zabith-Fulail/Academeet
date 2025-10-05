import 'package:flutter/material.dart';

class ActivitiesView extends StatefulWidget {
  const ActivitiesView({super.key});

  @override
  State<ActivitiesView> createState() => _ActivitiesViewState();
}

class _ActivitiesViewState extends State<ActivitiesView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.animation?.addListener(() {
      final newIndex = _tabController.animation!.value.round();
      if (_tabController.index != newIndex) {
        setState(() {}); // Rebuild to update the indicator color
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildTab(String label, Color color) {
    return Tab(
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildActivityCard({
    required Color backgroundColor,
    required Color textColor,
    required String status,
    required String dateTime,
    required String service,
    bool showProgress = false,
    double progressValue = 0.0,
    bool showLocation = false,
  }) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  service,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                if (showLocation)
                  const Icon(Icons.location_on, color: Colors.red),
                if (!showLocation && showProgress)
                  Row(
                    children: [
                      Icon(Icons.access_time, color: textColor, size: 16),
                      const SizedBox(width: 4),
                      Text('30 mins', style: TextStyle(color: textColor)),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Appointment ID      114', style: TextStyle(color: textColor)),
            Text('Salon Name           Blush Heaven', style: TextStyle(color: textColor)),
            Text('Expert Name         Maria', style: TextStyle(color: textColor)),
            Text('Date & Time         $dateTime', style: TextStyle(color: textColor)),
            Text('Sub Total              Rs. 800.00', style: TextStyle(color: textColor)),
            Text('Payment Status   Completed', style: TextStyle(color: textColor)),

            if (showProgress) ...[
              const SizedBox(height: 8),
              Text(status, style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: LinearProgressIndicator(
                  value: progressValue,
                  backgroundColor: Colors.pink.shade100,
                  color: Colors.pink,
                  minHeight: 8,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Activities', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
          elevation: 0,
          backgroundColor: Colors.white,
          leadingWidth: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TabBar(
                controller: _tabController,
                indicatorColor: _getIndicatorColor(_tabController.index),
                indicatorWeight: 3,
                labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                labelColor: Color(0xFFF5F5F5),
                tabs: [
                  _buildTab('Ongoing', Colors.blue),
                  _buildTab('Scheduled', Colors.orange),
                  _buildTab('Completed', Colors.green),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            /// Ongoing Tab
            ListView(
              children: [
                _buildActivityCard(
                  backgroundColor: Colors.blue[50]!,
                  textColor: Colors.blue,
                  status: 'In Progress',
                  dateTime: 'June 04, 2025 – 02:30PM',
                  service: 'Hair Cut',
                  showProgress: true,
                  progressValue: 0.6,
                ),
              ],
            ),

            /// Scheduled Tab
            ListView(
              children: [
                _buildActivityCard(
                  backgroundColor: Colors.orange[50]!,
                  textColor: Colors.orange,
                  status: 'Scheduled',
                  dateTime: 'June 04, 2025 – 02:30PM',
                  service: 'Hair Cut',
                  showLocation: true,
                ),
              ],
            ),

            /// Completed Tab
            ListView(
              children: [
                _buildActivityCard(
                  backgroundColor: Colors.green[50]!,
                  textColor: Colors.green.shade900,
                  status: 'Completed',
                  dateTime: 'June 04, 2025 – 02:30PM',
                  service: 'Hair Cut',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Color _getIndicatorColor(int index) {
    switch (index) {
      case 0:
        return Colors.blue;
      case 1:
        return Colors.orange;
      case 2:
        return Colors.green;
      default:
        return Colors.blue; // Default color
    }
  }
}
