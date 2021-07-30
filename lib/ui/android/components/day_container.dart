import 'package:flutter/material.dart';
import '/ui/theme/app_constants.dart';

class DayContainer extends StatefulWidget {
  final String day;
  final String date;

  const DayContainer({
    Key? key,
    required this.day,
    required this.date,
  }) : super(key: key);

  @override
  _DayContainerState createState() => _DayContainerState();
}

class _DayContainerState extends State<DayContainer> {
  var _isActive = false;
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context)
        .textTheme
        .bodyText1!
        .copyWith(color: const Color(0XFFD1D1D1));
    return GestureDetector(
      onTap: () {
        setState(() {
          _isActive = !_isActive;
        });
      },
      child: Container(
        width: 46,
        // height: 72,
        decoration: BoxDecoration(
          color: _isActive ? Constants.lightGreenColor : Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(6.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              widget.day,
              style: textStyle,
            ),
            Text(
              widget.date,
              style: textStyle,
            ),
            Text(
              '__',
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}
