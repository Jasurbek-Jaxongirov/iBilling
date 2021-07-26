import 'package:flutter/material.dart';

class DayContainer extends StatelessWidget {
  final String day;
  final String date;

  const DayContainer({
    Key? key,
    required this.day,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      height: 72,
      width: 46,

      child: Column(
        children: [
          Text(day),
          Text(date),
        ],
      ),
    );
  }
}
