import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/blocs/contract_cubit.dart';
import '/models/contract.dart';
import '/ui/android/components/calendar.dart';
import '/ui/theme/app_constants.dart';

import 'components/contract_item.dart';

class ContractsPage extends StatelessWidget {
  const ContractsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final buttonTextStyle =
        Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15);

    return Container(
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
            child: CustomCalendar(),
          ),
          Expanded(
            child: BlocBuilder<ContractCubit, List<ContractItem>>(
              builder: (context, state) {
                return FutureBuilder(
                  future: ContractCubit().getContracts(),
                  builder: (ctx, snapshot) {
                    if (snapshot.error == null) {
                      print(ContractCubit().getContracts());
                      print(state);
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        final data = snapshot.data as List<Contract>;
                        print(snapshot.error);
                        if (data.length == 0) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                  'assets/icons/empty-contracts.svg'),
                              SizedBox(
                                height: mediaQuery.size.height * 0.05,
                              ),
                              Text(
                                'No contracts are made',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          );
                        }
                        print('Worked');

                        print(data.length);

                        return SingleChildScrollView(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  MaterialButton(
                                    onPressed: () {
                                      ContractCubit().toggleButton(true);
                                    },
                                    child: Text(
                                      'Contract',
                                      style: buttonTextStyle,
                                    ),
                                    color: ContractCubit().isContractActive
                                        ? Constants.lightGreenColor
                                        : Colors.transparent,
                                  ),
                                  MaterialButton(
                                    onPressed: () {
                                      ContractCubit().toggleButton(false);
                                    },
                                    child: Text(
                                      'Invoice',
                                      style: buttonTextStyle,
                                    ),
                                    color: ContractCubit().isContractActive
                                        ? Colors.transparent
                                        : Constants.lightGreenColor,
                                  ),
                                ],
                              ),
                              ...data
                                  .map(
                                    (element) => Column(
                                      children: [
                                        ContractItem(
                                          contract: element,
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ],
                          ),
                        ));
                      }
                    } else {
                      print(snapshot.error);

                      print('Failed to work');
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'An error has occurred!',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          SizedBox(
                            height: mediaQuery.size.height * 0.05,
                          ),
                          Text(
                            'Sorry! Internal error has occured!',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      );
                    }

                    return Container();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
