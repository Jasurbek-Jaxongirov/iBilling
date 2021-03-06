import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/presentation/ui/android/components/single_contract_item.dart';
import '/business_logic/blocs/invoice/invoice_bloc.dart';
import '/presentation/ui/android/components/invoice_item.dart';
import '/business_logic/blocs/contracts/contracts_bloc.dart';
import '../components/contract_item.dart';
// import 'package:easy_localization/easy_localization.dart';

import 'empty_contracts.dart';

class ContractsAndIvoicesContainer extends StatefulWidget {
  const ContractsAndIvoicesContainer({
    Key? key,
    required this.isContract,
  }) : super(key: key);
  final bool isContract;

  @override
  _ContractsAndIvoicesContainerState createState() =>
      _ContractsAndIvoicesContainerState();
}

class _ContractsAndIvoicesContainerState
    extends State<ContractsAndIvoicesContainer> {
  var isClicked = false;

  @override
  Widget build(BuildContext context) {
    // Contracts
    if (widget.isContract)
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
            if (state is FilteredContractsByDate &&
                state.filteredContracts.isEmpty) {
              return const EmptyContracts();
            }
            if (state is LoadedContractsState)
              return ListView.separated(
                  // padding:
                  //   const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  separatorBuilder: (_, index) {
                    return const SizedBox(
                      height: 12,
                    );
                  },
                  itemCount: state.contracts.length,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onLongPress: () {
                        BlocProvider.of<ContractsBloc>(context, listen: false)
                            .isSelected = index;
                        isClicked = !isClicked;
                        setState(() {});
                      },
                      onDoubleTap: () {
                        isClicked = false;
                        setState(() {});
                      },
                      child: BlocProvider.of<ContractsBloc>(context,
                                          listen: false)
                                      .isSelected ==
                                  index &&
                              isClicked
                          ? SingleContractItem(contract: state.contracts[index])
                          : ContractItem(
                              contract: state.contracts[index],
                            ),
                    );
                  });
            else if (state is FilteredContractsByDate)
              return ListView.separated(
                  separatorBuilder: (_, index) {
                    return const SizedBox(
                      height: 12,
                    );
                  },
                  // padding:
                  // const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemCount: state.filteredContracts.length,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onLongPress: () {
                        BlocProvider.of<ContractsBloc>(context, listen: false)
                            .isSelected = index;
                        isClicked = !isClicked;
                        setState(() {});
                      },
                      onDoubleTap: () {
                        isClicked = false;
                        setState(() {});
                      },
                      child:
                          BlocProvider.of<ContractsBloc>(context, listen: false)
                                          .isSelected ==
                                      index &&
                                  isClicked
                              ? SingleContractItem(
                                  contract: state.filteredContracts[index])
                              : ContractItem(
                                  contract: state.filteredContracts[index],
                                ),
                    );
                  });
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
    // Invoices
    else {
      return BlocBuilder<InvoiceBloc, InvoiceState>(
        builder: (ctx, state) {
          if (state is LoadingInvoicesStates ||
              state is InvoiceInitial ||
              state is FilteringInvoicesByDate) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadedInvoicesStates ||
              state is FilteredInvoicesByDate) {
            if (state is LoadedInvoicesStates && state.invoices.isEmpty ||
                state is FilteredInvoicesByDate &&
                    state.filteredInvoices.isEmpty) {
              return const EmptyContracts();
            }
            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Column(
                  children: [
                    if (state is LoadedInvoicesStates)
                      ...state.invoices
                          .map(
                            (element) => Column(
                              children: [
                                InvoiceItem(invoice: element),
                                const SizedBox(
                                  height: 12,
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    if (state is FilteredInvoicesByDate)
                      ...state.filteredInvoices
                          .map(
                            (element) => Column(
                              children: [
                                InvoiceItem(invoice: element),
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
          } else if (state is FailedToLoadInvoices) {
            return Center(
              child: Text(
                '${state.error}',
                textAlign: TextAlign.center,
              ),
            );
          }
          return Container();
        },
      );
    }
  }
}
