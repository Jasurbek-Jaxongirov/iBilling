import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/business_logic/blocs/history/history_bloc.dart';
import '/presentation/ui/theme/app_constants.dart';
import 'package:jiffy/jiffy.dart';
import 'components/history_contracts_container.dart';
import 'package:easy_localization/easy_localization.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blocBuilder = BlocProvider.of<HistoryBloc>(context, listen: false);

    String timeReturner(String time) {
      if (time == '1') {
        if (blocBuilder.getInitialPeriod == '') {
          return 'from'.tr();
        }
        return Jiffy(blocBuilder.getInitialPeriod).format('dd.MM.yyyy');
      } else if (time == '2') {
        if (blocBuilder.getLastPeriod == '') {
          return 'to'.tr();
        }
        return Jiffy(blocBuilder.getLastPeriod).format('dd.MM.yyyy');
      } else {
        return '';
      }
    }

    final buttonTextStyle =
        Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15);
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodyText1!.copyWith(
      color: const Color(0XFF999999),
    );
    return BlocBuilder<HistoryBloc, HistoryState>(builder: (_, state) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        color: Constants.darkestColor,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'date'.tr(),
                    style: theme.textTheme.bodyText1!.copyWith(
                      color: const Color(0XFF999999),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: mediaQuery.size.width * 0.40,
                        child: MaterialButton(
                          color: Constants.darkColor,
                          onPressed: () async {
                            final pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(DateTime.now()
                                  .add(const Duration(days: 365))
                                  .year),
                            );
                            blocBuilder.setInitialPeriod =
                                pickedDate.toString();
                            if (!(blocBuilder.getInitialPeriod == '' ||
                                blocBuilder.getLastPeriod == '')) {
                              blocBuilder.add(LoadHistoryContractsEvent(
                                  blocBuilder.getInitialPeriod,
                                  blocBuilder.getLastPeriod));
                            }
                          },
                          child: Row(
                            children: [
                              Text(
                                timeReturner('1') == ''
                                    ? 'from'.tr()
                                    : '${timeReturner('1')}',
                                style: textStyle,
                              ),
                              const Spacer(),
                              SvgPicture.asset('assets/icons/calendar-bold.svg')
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: mediaQuery.size.width * 0.02),
                        child: const Text(
                          ' - ',
                          style: TextStyle(
                              color: Color(0XFFD1D1D1),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: mediaQuery.size.width * 0.40,
                        child: MaterialButton(
                          color: Constants.darkColor,
                          onPressed: () async {
                            final pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(DateTime.now()
                                  .add(const Duration(days: 365))
                                  .year),
                            );
                            blocBuilder.setLastPeriod = pickedDate.toString();
                            if (!(blocBuilder.getInitialPeriod == '' ||
                                blocBuilder.getLastPeriod == '')) {
                              blocBuilder.add(LoadHistoryContractsEvent(
                                  blocBuilder.getInitialPeriod,
                                  blocBuilder.getLastPeriod));
                            }
                          },
                          child: Row(
                            children: [
                              Text(
                                timeReturner('2') == ''
                                    ? 'to'.tr()
                                    : '${timeReturner('2')}',
                                style: textStyle,
                              ),
                              const Spacer(),
                              SvgPicture.asset('assets/icons/calendar-bold.svg')
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocProvider.of<HistoryBloc>(context).historyContracts ==
                      []
                  ? EmptyHistoryList(
                      theme: theme,
                    )
                  : HistoryContractsContainer(buttonTextStyle: buttonTextStyle),
            )
          ],
        ),
      );
    });
  }
}

class EmptyHistoryList extends StatelessWidget {
  const EmptyHistoryList({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset('assets/icons/empty-contracts.svg'),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        Text(
          'empty'.tr(),
          style: theme.textTheme.bodyText1,
        ),
      ],
    );
  }
}
