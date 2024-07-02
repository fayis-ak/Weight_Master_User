import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:weigh_master/Data/db_service.dart';
import 'package:weigh_master/Data/payment_service.dart';
import 'package:weigh_master/Presentation/log_and_register/spalsh_screen.dart';
import 'package:weigh_master/Presentation/log_and_register/login.dart';
import 'package:weigh_master/Presentation/log_and_register/register.dart';
import 'package:weigh_master/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // name: "weigh_master",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        ChangeNotifierProvider<DBService>(create: (_)=>DBService()),
        ChangeNotifierProvider<PaymentController>(create: (_)=>PaymentController())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'wighmaster',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 124, 243, 225)),
          useMaterial3: true,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
