import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../core/theme/theme_data.dart';
import '../../../../utils/app_styling.dart';
import '../../../../utils/navigation_routes.dart';
class BookingDateTimeView extends StatefulWidget {
  const BookingDateTimeView({super.key});

  @override
  State<BookingDateTimeView> createState() => _BookingDateTimeViewState();
}

class _BookingDateTimeViewState extends State<BookingDateTimeView> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDate;
  bool _showCalendar = false;
  String? _selectedTime;

  final List<String> _timeSlots = [
    '10:00 AM', '10:30 AM', '11:00 AM', '11:30 AM',
    '02:00 PM', '02:30 PM', '04:00 PM', '04:30 PM',
    '05:00 PM', '06:00 PM', '07:00 PM', '07:30 PM',
    '08:00 PM', '08:30 PM', '09:30 PM', '09:30 PM',
  ];

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
      body: SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Select Date", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey)),
              const SizedBox(height: 8),
              InkWell(
                onTap: () {
                  setState(() {
                    _showCalendar = !_showCalendar;
                  });
                },
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: colors(context).primaryColor500,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _selectedDate == null
                              ? "DD/ MM/ YY"
                              : DateFormat('dd/MM/yyyy').format(_selectedDate!),
                          style: const TextStyle(fontSize: 16,color: Colors.grey),
                        ),
                      ),
                      const Icon(Icons.calendar_today, color: Colors.grey),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              if (_showCalendar)
                AnimatedCrossFade(
                  firstChild: const SizedBox.shrink(),
                  secondChild: Container(
                    margin: const EdgeInsets.only(top: 8,bottom: 16,right: 2,left: 2), // small spacing from input
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: colors(context).primaryColor500!,
                          blurRadius: 2,
                          // spreadRadius: 2,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: TableCalendar(
                      firstDay: DateTime.now(),
                      lastDay: DateTime(2100),
                      focusedDay: _focusedDay,
                      selectedDayPredicate: (day) => isSameDay(day, _selectedDate),
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDate = selectedDay;
                          _focusedDay = focusedDay;
                          _showCalendar = false;
                        });
                      },
                      calendarStyle: CalendarStyle(
                        selectedDecoration: BoxDecoration(
                          color: colors(context).primaryColor800!,
                          shape: BoxShape.circle,
                        ),
                        todayDecoration: BoxDecoration(
                          color: colors(context).primaryColor500!,
                          shape: BoxShape.circle,
                        ),
                        weekendTextStyle: const TextStyle(color: Colors.black54),
                        defaultTextStyle: const TextStyle(color: Colors.black),
                      ),
                      headerStyle: const HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        titleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        leftChevronIcon: Icon(Icons.chevron_left, color: Colors.black),
                        rightChevronIcon: Icon(Icons.chevron_right, color: Colors.black),
                      ),
                      daysOfWeekStyle: const DaysOfWeekStyle(
                        weekendStyle: TextStyle(color: Colors.black54),
                        weekdayStyle: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  crossFadeState: _showCalendar
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 400),
                ),
              const SizedBox(height: 24),
              const Text("Select Time", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Center(
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: _timeSlots.map((time) {
                    final isSelected = _selectedTime == time;
                    return GestureDetector(
                      onTap: () {
                        setState(() => _selectedTime = time);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: isSelected ? colors(context).primaryColor500! : Colors.black),
                          borderRadius: BorderRadius.circular(8),
                          color: isSelected ? colors(context).primaryColor800! : Colors.white,
                        ),
                        child: Text(
                          time,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 84),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, Routes.kPaymentView);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: colors(context).buttonPrimaryColor!
                    ),
                    child: Center(
                      child: Text(
                        "CONFIRM APPOINTMENT",
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
      ),
    );
  }
}
