import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:projectname_flutter_project/Providers/wallet_provider.dart';
import 'package:projectname_flutter_project/Services/contract_service.dart';
import 'package:projectname_flutter_project/Services/wallet_service.dart';
import 'package:web3dart/web3dart.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _textFieldController = TextEditingController();
  String name = "";
  double balance = 0.0;

  @override
  void initState() {
    init();
    super.initState();
  }

  String ethAddress = "";

  ContractService contractService = ContractService();
  WalletService walletService = WalletService();
  WalletProvider walletProvider = WalletProvider();
  void init() {
    walletService.getPrivateKey().then((value) {
      setState(() {
        ethAddress = EthPrivateKey.fromHex(value).address.hex;
      });
    });
    getBalance();
  }

  void getBalance() {
    walletProvider.getBalance().then((value) {
      setState(() {
        balance = value;
      });
    });
  }

  void setData(String name) {
    Future.delayed(const Duration(seconds: 1), () {
      contractService.setStringFunction(name).then((value) {
        getData();
      }).onError((error, stackTrace) {
        Fluttertoast.showToast(msg: error.toString());
      });
    });
  }

  void getData() {
    contractService.getStringFunction().then((value) {
      setState(() {
        name = value;
        print(value);
      });
    });
  }

  Future showTextFieldPopup() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Enter your name"),
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: "Enter your name"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  name = _textFieldController.text;
                });
                setData(_textFieldController.text);
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text("Your Flutter DApp"),
          centerTitle: true,
        ),
        body: Center(
          child: SizedBox(
            width: 700,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  name.isNotEmpty
                      ? Text(
                          "Hello, ${_textFieldController.text}",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        )
                      : const Text(""),
                  const SizedBox(
                    height: 30,
                  ),
                  TextButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: ethAddress));
                        Fluttertoast.showToast(msg: "Copied to clipboard");
                      },
                      child: Text(ethAddress)),
                  const SizedBox(
                    height: 30,
                  ),
                  TextButton(
                    onPressed: init,
                    child: Text("Balance: $balance"),
                  ),
                  Image.asset("assets/image.png"),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: const BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: Text(
            "Crafting with ❤️ by Mohit Gajjar",
            textAlign: TextAlign.center,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showTextFieldPopup();
          },
          child: const Icon(Icons.message_outlined),
        ));
  }
}
