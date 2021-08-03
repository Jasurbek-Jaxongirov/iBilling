import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/blocs/history/history_bloc.dart';
import '/ui/theme/app_constants.dart';
import '../components/contract_item.dart';
import 'package:easy_localization/easy_localization.dart';

class HistoryContractsContainer extends StatelessWidget {
  const HistoryContractsContainer({
    Key? key,
    required this.buttonTextStyle,
  }) : super(key: key);

  final TextStyle buttonTextStyle;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(
      builder: (ctx, state) {
        if (state is LoadingHistoryContractsState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is LoadedHistoryContractsState) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      MaterialButton(
                        onPressed: () {},
                        child: Text(
                          'contract'.tr(),
                          style: buttonTextStyle,
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {},
                        child: Text(
                          Constants.invoice,
                          style: buttonTextStyle,
                        ),
                      ),
                    ],
                  ),
                  if (state is LoadedHistoryContractsState)
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
                ],
              ),
            ),
          );
        } else if (state is FailedToLoadHistoryContractsState) {
          return Center(
            child: Text(
              '${state.error}',
              textAlign: TextAlign.center,
            ),
          );
        }
        if (state is HistoryInitial) {
          return Container();
        }
        return Container();
      },
    );
  }
}
