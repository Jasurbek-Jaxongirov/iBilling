import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/presentation/ui/theme/app_constants.dart';
import '/business_logic/blocs/contracts/contracts_bloc.dart';
import '../components/contract_item.dart';
import 'package:easy_localization/easy_localization.dart';

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
        if (state is LoadingContractsState ||
            state is ContractsInitialState ||
            state is FilteringContractsByDate) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is LoadedContractsState ||
            state is FilteredContractsByDate) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      MaterialButton(
                        onPressed: () {
                          setState(() {});
                        },
                        child: Text(
                          'contract'.tr(),
                          style: widget.buttonTextStyle,
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          setState(() {});
                        },
                        child: Text(
                          Constants.invoice,
                          style: widget.buttonTextStyle,
                        ),
                      ),
                    ],
                  ),
                  if (state is LoadedContractsState)
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
                        .toList()
                  else if (state is FilteredContractsByDate)
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
        } else if (state is FailedToLoadContractsState ||
            state is FailedToFilterContractsByDate) {
          return Center(
            child: Text(
              state is FailedToLoadContractsState
                  ? '${state.error}'
                  : state is FailedToFilterContractsByDate
                      ? '${state.error}'
                      : 'Sorry, an internal error occured!',
              textAlign: TextAlign.center,
            ),
          );
        }
        return Container();
      },
    );
  }
}
