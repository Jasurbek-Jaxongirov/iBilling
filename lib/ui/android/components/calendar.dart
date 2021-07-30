import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/ui/theme/app_constants.dart';
import 'day_container.dart';
import 'package:jiffy/jiffy.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({Key? key}) : super(key: key);
  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  var pickedDate = DateTime.now();
  var jiffy1 = Jiffy();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) => Container(
        padding: EdgeInsets.symmetric(
            vertical: constraints.maxWidth * 0.0426,
            horizontal: constraints.maxHeight * 0.122),
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        color: Constants.darkerColor,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  Jiffy(pickedDate.toString()).format('MMMM, yyyy '),
                  style: Theme.of(context).textTheme.headline5,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    setState(() {
                      pickedDate = pickedDate.subtract(
                        const Duration(days: 7),
                      );
                    });
                  },
                  icon: SvgPicture.asset('assets/icons/arrow-left.svg'),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      pickedDate = pickedDate.add(const Duration(days: 7));
                    });
                  },
                  icon: SvgPicture.asset('assets/icons/right-arrow.svg'),
                ),
              ],
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (_, index) => SizedBox(
                  width: constraints.maxWidth * 0.04,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                itemBuilder: (_, index) => DayContainer(
                  day: Jiffy(
                    pickedDate.add(Duration(days: index)).toString(),
                  ).format('E'),
                  date: Jiffy(
                    pickedDate.add(Duration(days: index)).toString(),
                  ).format('dd'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
