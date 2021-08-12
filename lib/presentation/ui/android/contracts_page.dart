import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/business_logic/blocs/contracts/contracts_bloc.dart';
import 'components/calendar.dart';
import 'components/contracts_invoices_container.dart';
import 'package:easy_localization/easy_localization.dart';

class ContractsPage extends StatefulWidget {
  const ContractsPage({Key? key}) : super(key: key);

  @override
  _ContractsPageState createState() => _ContractsPageState();
}

class _ContractsPageState extends State<ContractsPage> {
  var isContract = true;
  @override
  Widget build(BuildContext context) {
    final buttonTextStyle =
        Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15);
    return BlocBuilder<ContractsBloc, ContractsState>(
      builder: (_, state) => Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 148,
              child: CustomCalendar(),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<ContractsBloc>(context, listen: false)
                    ..add(LoadContracts());
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      child: Row(
                        children: [
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            color: isContract
                                ? const Color(0xFF00A795)
                                : Colors.black,
                            onPressed: () {
                              setState(() {
                                isContract = true;
                              });
                            },
                            child: Text(
                              'contract'.tr(),
                              style: buttonTextStyle,
                            ),
                          ),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            color: !isContract
                                ? const Color(0xFF00A795)
                                : Colors.black,
                            onPressed: () {
                              setState(() {
                                isContract = false;
                              });
                            },
                            child: Text(
                              'invoice'.tr(),
                              style: buttonTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: ContractsAndIvoicesContainer(
                            isContract: isContract),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
