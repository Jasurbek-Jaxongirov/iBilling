import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/business_logic/blocs/invoice/invoice_bloc.dart';
import '/business_logic/blocs/contracts/contracts_bloc.dart';
import '/presentation/ui/theme/app_constants.dart';
import 'day_container.dart';
import 'package:jiffy/jiffy.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({
    Key? key,
  }) : super(key: key);
  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime pickedDate =
      DateTime.now().subtract(Duration(days: (DateTime.now().weekday - 1)));
  var jiffy1 = Jiffy();
  var _selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
//     final pickedIndexDay =
// pickedDate.add(Duration(days: index));
//     final pickedIndexDate =
// pickedDate.add(Duration(days: index));
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
                      _selectedIndex = -1;
                      pickedDate = pickedDate.subtract(
                        const Duration(days: 7),
                      );
                    });
                    BlocProvider.of<ContractsBloc>(context)
                        .add(LoadContracts());
                  },
                  icon: SvgPicture.asset('assets/icons/arrow-left.svg'),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _selectedIndex = -1;
                      pickedDate = pickedDate.add(const Duration(days: 7));
                    });
                    BlocProvider.of<ContractsBloc>(context)
                        .add(LoadContracts());
                  },
                  icon: SvgPicture.asset('assets/icons/right-arrow.svg'),
                ),
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int index = 0; index < 6; index++)
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                        });
                        BlocProvider.of<ContractsBloc>(context).setDate =
                            pickedDate.add(Duration(days: index)).toString();
                        BlocProvider.of<ContractsBloc>(context).add(
                            FilterContractsByDate(pickedDate
                                .add(Duration(days: index))
                                .toString()));
                        BlocProvider.of<InvoiceBloc>(context).setDate =
                            pickedDate.add(Duration(days: index)).toString();
                        BlocProvider.of<InvoiceBloc>(context).add(
                            FilterInvoicesByDate(pickedDate
                                .add(Duration(days: index))
                                .toString()));
                      },
                      child: DayContainer(
                        isActive: _selectedIndex == index,
                        day: Jiffy(
                          pickedDate.add(Duration(days: index)),
                        ).format('E'),
                        date: Jiffy(
                          pickedDate.add(Duration(days: index)),
                        ).format('dd'),
                        index: index,
                        selectedIndex: _selectedIndex,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// child: ListView.separated(
//   separatorBuilder: (_, index) => SizedBox(
//     width: constraints.maxWidth * 0.04,
//   ),
//   scrollDirection: Axis.horizontal,
//   itemCount: 6,
//   itemBuilder: (_, index) {
//     final pickedIndexDay =
//pickedDate.add(Duration(days: index));
//     final pickedIndexDate =
//pickedDate.add(Duration(days: index));

//     return InkWell(
//       onTap: () {
//         setState(() {
//           _selectedIndex = index;
//         });
//         BlocProvider.of<ContractsBloc>(context).setDate =
//             pickedIndexDay.toString();
//         BlocProvider.of<ContractsBloc>(context).add(
//             FilterContractsByDate(pickedIndexDay.toString()));
//         BlocProvider.of<InvoiceBloc>(context).setDate =
//             pickedIndexDay.toString();
//         BlocProvider.of<InvoiceBloc>(context)
//    .add(FilterInvoicesByDate(pickedIndexDay.toString()));
//       },
//       child: DayContainer(
//         isActive: _selectedIndex == index,
//         day: Jiffy(
//           pickedIndexDay,
//         ).format('E'),
//         date: Jiffy(
//           pickedIndexDate,
//         ).format('dd'),
//         index: index,
//         selectedIndex: _selectedIndex,
//       ),
//     );
//   },
