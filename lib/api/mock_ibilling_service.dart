import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/contract.dart';

class MockIBillingService {
  Future<List<Contract>> getContractResponse() async {
    final contracts = await _getContracts();

    return contracts;
  }

  Future<List<Contract>> _getContracts() async {
    await Future.delayed(const Duration(seconds: 2));
    final contractString = await _loadAsset('assets/sample_json/contracts.json');

    final jsonData = json.decode(contractString);

    final contracts = ContractResponse.fromJson(jsonData);
    return contracts.contracts;

  }

  Future<String> _loadAsset(String path) async {
    return rootBundle.loadString(path);
  }
}

