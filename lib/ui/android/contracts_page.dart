import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_billing/blocs/filter_by_date/filter_by_date_bloc.dart';

import '/ui/android/components/calendar.dart';
import '/ui/theme/app_constants.dart';
import 'components/contracts_invoices_container.dart';

class ContractsPage extends StatelessWidget {
  const ContractsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final buttonTextStyle =
        Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15);

    return BlocBuilder<FilterByDateBloc, FilterByDateState>(
      builder: (context, state) => Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Constants.darkestColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: mediaQuery.size.height * 0.25,
              child: const CustomCalendar(),
            ),
            Expanded(
              child: ContractsAndIvoicesContainer(
                  buttonTextStyle: buttonTextStyle),
            ),
          ],
        ),
      ),
    );
  }
}
