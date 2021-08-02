import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/blocs/contracts/contracts_bloc.dart';
// import '/blocs/contracts_bloc/contracts_bloc_bloc.dart';

import 'package:easy_localization/easy_localization.dart';
import '../components/contract_item.dart';

class ContractsAndIvoicesContainer extends StatefulWidget {
  const ContractsAndIvoicesContainer({
    Key? key,
    required this.buttonTextStyle,
  }) : super(key: key);

  final TextStyle buttonTextStyle;

  @override
  _ContractsAndIvoicesContainerState createState() =>
      _ContractsAndIvoicesContainerState();
}

class _ContractsAndIvoicesContainerState
    extends State<ContractsAndIvoicesContainer> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContractsBloc, ContractsState>(
      builder: (ctx, state) {
        if (state is LoadingContractsState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is LoadedContractsState) {
          print('Worked');
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            context.locale = const Locale('ru');
                          });
                          // ContractCubit().toggleButton(true);
                        },
                        child: Text(
                          'contract'.tr(),
                          style: widget.buttonTextStyle,
                        ),
                        // color: ContractCubit().isContractActive
                        // ? Constants.lightGreenColor
                        // : Colors.transparent,
                      ),
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            context.locale = const Locale('uz');
                          });
                          // ContractCubit().toggleButton(false);
                        },
                        child: Text(
                          'Invoice',
                          style: widget.buttonTextStyle,
                        ),
                        // color: ContractCubit().isContractActive
                        // ? Colors.transparent
                        // : Constants.lightGreenColor,
                      ),
                    ],
                  ),
                  ...state.contracts
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
            ),
          );
        } else if (state is FailedToLoadContractsState) {
          return Center(
            child: Text('${state.error}'),
          );
        } else if (state is FilteringContractsByDate) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is FilteredContractsByDate) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            context.locale = const Locale('ru');
                          });
                          // ContractCubit().toggleButton(true);
                        },
                        child: Text(
                          'contract'.tr(),
                          style: widget.buttonTextStyle,
                        ),
                        // color: ContractCubit().isContractActive
                        // ? Constants.lightGreenColor
                        // : Colors.transparent,
                      ),
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            context.locale = const Locale('uz');
                          });
                          // ContractCubit().toggleButton(false);
                        },
                        child: Text(
                          'Invoice',
                          style: widget.buttonTextStyle,
                        ),
                        // color: ContractCubit().isContractActive
                        // ? Colors.transparent
                        // : Constants.lightGreenColor,
                      ),
                    ],
                  ),
                  ...state.filteredContracts
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
            ),
          );
        } else if (state is FailedToFilterContractsByDate) {
          print('failed to filter');
        }
        print('Failed');
        return Container();
      },
    );
  }
}
