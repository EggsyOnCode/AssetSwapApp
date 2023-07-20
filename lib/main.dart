import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xen_wallet/firebase/GoogleSignInProvider.dart';
import 'package:xen_wallet/screens/assets.dart';
import 'package:xen_wallet/screens/home.dart';
import 'package:xen_wallet/screens/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:xen_wallet/screens/signup.dart';
import 'package:xen_wallet/screens/trades.dart';
import 'package:xen_wallet/wallet/generate_wallet.dart';
import 'package:xen_wallet/wallet/mnemonic.dart';
import 'package:xen_wallet/wallet/waller_provider.dart';
import 'package:xen_wallet/wallet/wallet_home.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),
        ChangeNotifierProvider(create: (context) => WalletProvider())
      ],
      child: MaterialApp(
        theme: ThemeData(textTheme: GoogleFonts.eczarTextTheme()),
        routes: {
          '/login': (context) => const Login(),
          '/signup': (context) => const SignUp(),
          '/trades': (context) => const Trades(),
          '/assets': (context) => const Assets(),
          '/main': (context) => const HomePage(),
        },
        debugShowCheckedModeBanner: false,
        title: 'Your App',
        home: WalletGenerate(), // Use your custom widget here
      ),
    );
  }
}
