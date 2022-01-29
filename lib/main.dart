import 'package:cozy_bwa/pages/splash_page.dart';
import 'package:cozy_bwa/providers/space_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SpaceProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashPage(),
      ),
    );
  }
}
