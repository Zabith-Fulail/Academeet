import 'package:flutter/material.dart';
import '../../../../../core/theme/theme_data.dart';

class NotificationCard extends StatefulWidget {
  const NotificationCard({
    super.key,
    required this.title,
    required this.description,
    required this.time,
    this.icon = Icons.notifications,
    this.iconBackgroundColor,
    this.onTap,
  });

  final String title;
  final String description;
  final String time;
  final IconData icon;
  final Color? iconBackgroundColor;
  final VoidCallback? onTap;

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    final appColors = colors(context);
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: appColors.surfacePrimary,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: appColors.grayColor!.withValues(alpha: .2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color:
                      widget.iconBackgroundColor ?? appColors.primaryColor500,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  widget.icon,
                  color: appColors.whiteColor,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: appColors.primaryTextColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: appColors.neutral,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.time,
                          style: TextStyle(
                            fontSize: 12,
                            color: appColors.grayColor,
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      widget.icon,
                      color: appColors.whiteColor,
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
