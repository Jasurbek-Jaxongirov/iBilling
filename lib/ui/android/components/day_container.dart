import 'package:flutter/material.dart';
import '/ui/theme/app_constants.dart';

class DayContainer extends StatelessWidget {
  final String day;
  final String date;
  final isActive;
  const DayContainer({
    Key? key,
    required this.day,
    required this.date,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context)
        .textTheme
        .bodyText1!
        .copyWith(color: const Color(0XFFD1D1D1));
    return Container(
      width: 46,
      // height: 72,
      decoration: BoxDecoration(
        color: isActive ? Constants.lightGreenColor : Colors.transparent,
        borderRadius: const BorderRadius.all(Radius.circular(6.0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            day,
            style: textStyle,
          ),
          Text(
            date,
            style: textStyle,
          ),
          Text(
            '__',
            style: textStyle,
          ),
        ],
      ),
    );
  }
}
