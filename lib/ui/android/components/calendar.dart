import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_billing/ui/theme/app_constants.dart';
import 'day_container.dart';
import 'package:jiffy/jiffy.dart';

class CustomCalendar extends StatefulWidget {
  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  var pickedDate = DateTime.now();
  var _isActive = false;

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
                Spacer(),
                IconButton(
                  onPressed: () {
                    setState(() {
                      pickedDate = pickedDate.subtract(
                        Duration(days: 6),
                      );
                    });
                  },
                  icon: SvgPicture.asset('assets/icons/arrow-left.svg'),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      pickedDate = pickedDate.add(Duration(days: 6));
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

/*
Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(
            children: [
              Row(
                children: [
                  Text(
                    '${Jiffy(pickedDate.toString()).format("yyyy, MMMM ")}',
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () {

                      },
                      icon: Icon(Icons.arrow_back_ios)),
                  IconButton(
                      onPressed: () {

                      },
                      icon: Icon(Icons.arrow_forward_ios)),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: constraints.maxWidth * 0.04693,
                        vertical: constraints.maxHeight * 0.08108),
                    width: constraints.maxWidth,
                    height: constraints.maxHeight * 0.4594,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (_, index) {
                          return SizedBox(
                            width: 5,
                          );
                        },
                        itemCount: 7,
                        itemBuilder: (_, index) {
                          return DayContainer(
                            day: Jiffy(pickedDate
                                    .add(Duration(days: index))
                                    .toString())
                                .format('E'),
                            date: Jiffy(pickedDate
                                    .add(Duration(days: index))
                                    .toString())
                                .format('dd'),
                          );
                        }),
                  )
                ],
              ),
            ],
          ),
        ],
      ),

 */
