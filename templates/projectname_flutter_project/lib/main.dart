import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectname_flutter_project/Providers/wallet_provider.dart';
import 'package:projectname_flutter_project/Screens/home.dart';
import 'package:projectname_flutter_project/Services/contract_service.dart';
import 'package:projectname_flutter_project/Services/wallet_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<WalletService>(create: (_) => WalletService()),
        ChangeNotifierProvider<WalletProvider>(create: (_) => WalletProvider()),
        ChangeNotifierProvider<ContractService>(
            create: (_) => ContractService()),
      ],
      child: MaterialApp(
        title: 'Your Flutter Dapp',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        home: const MainPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    checkWallet();
    super.initState();
  }

  bool isInitialized = false;
  WalletProvider walletProvider = WalletProvider();
  WalletService walletService = WalletService();
  void checkWallet() {
    walletService.getPrivateKey().then((value) {
      print("asdfasdfasf: " + value);
      if (value.isNotEmpty) {
        createWallet();
      } else {
        setState(() {
          isInitialized = true;
        });
      }
    });
  }
  void createWallet() {
    setState(() {
      isInitialized = false;
    });

    walletProvider.createWallet();
    setState(() {
      isInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isInitialized
        ? const Home()
        : const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
