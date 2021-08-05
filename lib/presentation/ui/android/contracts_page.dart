import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/presentation/ui/theme/app_constants.dart';
import '/business_logic/blocs/contracts/contracts_bloc.dart';
import 'components/calendar.dart';
import 'components/contracts_invoices_container.dart';

class ContractsPage extends StatelessWidget {
  const ContractsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final buttonTextStyle =
        Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15);
    return BlocBuilder<ContractsBloc, ContractsState>(
      builder: (_, state) => Container(
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
