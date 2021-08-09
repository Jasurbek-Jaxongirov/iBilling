import 'package:json_annotation/json_annotation.dart';

part 'contract.g.dart';

@JsonSerializable()
class ContractResponse {
  List<Contract> contracts;
  List<Invoice> invoice;

  ContractResponse({
    required this.contracts,
    required this.invoice,
  });

  factory ContractResponse.fromJson(Map<String, dynamic> json) =>
      _$ContractResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ContractResponseToJson(this);
}

@JsonSerializable()
class Invoice {
  @JsonKey(name: 'service_name')
  String serviceName;
  @JsonKey(name: 'invoice_status')
  String invoiceStatus;
  int amount;
  @JsonKey(name: 'created_at')
  String createdAt;

  Invoice(
      {required this.serviceName,
      required this.invoiceStatus,
      required this.amount,
      required this.createdAt});

  factory Invoice.fromJson(Map<String, dynamic> json) =>
      _$InvoiceFromJson(json);
  Map<String, dynamic> toJson() => _$InvoiceToJson(this);
}

@JsonSerializable()
class Contract {
  @JsonKey(name: 'full_name')
  String fullName;
  @JsonKey(name: 'contract_status')
  String contractStatus;
  int amount;
  @JsonKey(name: 'last_invoice')
  int lastInvoice;
  @JsonKey(name: 'invoice_amount')
  int invoiceAmount;
  String address;
  @JsonKey(name: 'created_at')
  String createdAt;
  @JsonKey(name: 'organization_itn')
  int organizationItn;

  Contract({
    required this.fullName,
    required this.contractStatus,
    required this.amount,
    required this.lastInvoice,
    required this.invoiceAmount,
    required this.address,
    required this.createdAt,
    required this.organizationItn,
  });

  factory Contract.fromJson(Map<String, dynamic> json) =>
      _$ContractFromJson(json);
  Map<String, dynamic> toJson() => _$ContractToJson(this);
}
