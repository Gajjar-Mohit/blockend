import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:projectname_flutter_project/Services/wallet_service.dart';
import 'package:projectname_flutter_project/config/keys.dart';
import 'package:web3dart/web3dart.dart';

class ContractService extends ChangeNotifier {
  String? _privateKey;

  final Web3Client _web3client = Web3Client(rpcUrl, Client());
  WalletService walletService = WalletService();
  String? _abiCode;
  EthereumAddress? _contractAddress;
  Credentials? _credentials;
  DeployedContract? _deployedContract;

  ContractFunction? setString;
  ContractFunction? getString;

  ContractService() {
    initialSetup();
  }
  void initialSetup() async {
    await getAbi();
    _privateKey = await walletService.getPrivateKey();
    getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    String abiStringFile =
        await rootBundle.loadString("assets/abis/StringStorage.json");
    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi["abi"]);
    _contractAddress =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
    notifyListeners();
  }

  void getCredentials() {
    if (kDebugMode) {
      print(_privateKey);
    }
    _credentials = EthPrivateKey.fromHex(_privateKey!);
    if (kDebugMode) {
      print(_credentials!.address.toString());
    }
    if (kDebugMode) {
      print("Got the creds");
    }
    notifyListeners();
  }

  Future<void> getDeployedContract() async {
    _deployedContract = DeployedContract(
        ContractAbi.fromJson(_abiCode!, "StringStorage"), _contractAddress!);

    setString = _deployedContract!.function("setString");
    getString = _deployedContract!.function("getString");

    if (kDebugMode) {
      print("Got the deployed contract");
    }
    notifyListeners();
  }

  Future<void> setStringFunction(String stringToSet) async {
    await _web3client.sendTransaction(
        _credentials!,
        Transaction.callContract(
            contract: _deployedContract!,
            function: setString!,
            parameters: [stringToSet]),
        chainId: 1337);
    notifyListeners();
  }

  Future<String> getStringFunction() async {
    final result = await _web3client
        .call(contract: _deployedContract!, function: getString!, params: []);
    notifyListeners();
    return result[0] as String;
  }
}
