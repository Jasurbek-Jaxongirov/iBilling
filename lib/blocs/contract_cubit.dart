import 'package:bloc/bloc.dart';
import 'package:i_billing/api/mock_ibilling_service.dart';
import 'package:i_billing/models/contract.dart';
import 'package:i_billing/ui/android/components/contract_item.dart';


class ContractCubit extends Cubit<List<ContractItem>> {

  List<Contract> mockData = [];
  List<ContractItem> contractItemWidgets = [];
  ContractCubit() : super([]);

  Future<List<Contract> > getContracts() async {
    return mockData = await MockIBillingService().getContractResponse();
  }



  Future<List<ContractItem>> getContractItemWidgets() async {
    await getContracts();
    if (mockData == []) {
      return [];
    }
    mockData.forEach((itemData) {
      contractItemWidgets.add(ContractItem(lastInvoice: itemData.lastInvoice,
          contractStatus: itemData.contractStatus));
    });
    emit(contractItemWidgets);
    return contractItemWidgets;
  }
}
