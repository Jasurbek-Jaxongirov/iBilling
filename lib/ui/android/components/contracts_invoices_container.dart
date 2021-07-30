import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/blocs/filter_by_date/filter_by_date_bloc.dart';
// import '/blocs/contracts_bloc/contracts_bloc_bloc.dart';
import '../components/contract_item.dart';

class ContractsAndIvoicesContainer extends StatelessWidget {
  ContractsAndIvoicesContainer({
    Key? key,
    required this.buttonTextStyle,
  }) : super(key: key);

  final TextStyle buttonTextStyle;
  final bloc = FilterByDateBloc()..add(ClickDateContainer());
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterByDateBloc, FilterByDateState>(
      bloc: bloc,
      builder: (ctx, state) {
        print(ctx.toString());
        bloc.toggleClick(true);
        if (state is FilteringByDate) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is FilteredByDate) {
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
                          // ContractCubit().toggleButton(true);
                        },
                        child: Text(
                          'Contract',
                          style: buttonTextStyle,
                        ),
                        // color: ContractCubit().isContractActive
                        // ? Constants.lightGreenColor
                        // : Colors.transparent,
                      ),
                      MaterialButton(
                        onPressed: () {
                          // ContractCubit().toggleButton(false);
                        },
                        child: Text(
                          'Invoice',
                          style: buttonTextStyle,
                        ),
                        // color: ContractCubit().isContractActive
                        // ? Colors.transparent
                        // : Constants.lightGreenColor,
                      ),
                    ],
                  ),
                  ...state.contractsFilteredByDate
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
        } else if (state is FailedToFilterByDate) {
          return Center(
            child: Text('${state.error}'),
          );
        } else {
          print('Failed');
          return Container();
        }
      },
    );
  }
}
