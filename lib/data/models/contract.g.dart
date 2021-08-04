// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContractResponse _$ContractResponseFromJson(Map<String, dynamic> json) {
  return ContractResponse(
    contracts: (json['contracts'] as List<dynamic>)
        .map((e) => Contract.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ContractResponseToJson(ContractResponse instance) =>
    <String, dynamic>{
      'contracts': instance.contracts,
    };

Contract _$ContractFromJson(Map<String, dynamic> json) {
  return Contract(
    fullName: json['full_name'] as String,
    contractStatus: json['contract_status'] as String,
    amount: json['amount'] as int,
    lastInvoice: json['last_invoice'] as int,
    invoiceAmount: json['invoice_amount'] as int,
    address: json['address'] as String,
    createdAt: json['created_at'] as String,
    organizationItn: json['organization_itn'] as int,
  );
}

Map<String, dynamic> _$ContractToJson(Contract instance) => <String, dynamic>{
      'full_name': instance.fullName,
      'contract_status': instance.contractStatus,
      'amount': instance.amount,
      'last_invoice': instance.lastInvoice,
      'invoice_amount': instance.invoiceAmount,
      'address': instance.address,
      'created_at': instance.createdAt,
      'organization_itn': instance.organizationItn,
    };
