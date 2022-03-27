import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/app/data/Providers/providers.dart';
import 'package:flutter_login/app/pages/loginPage.dart';
import 'package:flutter_login/app/pages/registrationPage.dart';
import 'package:flutter_login/app/utils/colors.dart';
import 'package:provider/provider.dart';

import 'app/widgets/mainPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider())
      ],
      child: MaterialApp(
        title: 'Login Page',
        theme: ThemeData.dark().copyWith(),
        debugShowCheckedModeBanner: false,
        // home: RegistrationPage(),
        home: Scaffold(
          body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.active)
                {
                  if(snapshot.hasData)
                    {
                      return const MainPage();
                    }
                  else if(snapshot.hasError)
                    {
                      return Center(
                        child: Text('${snapshot.error}'),
                      );
                    }
                }
              if(snapshot.connectionState == ConnectionState.waiting)
                {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  );
                }
              return LoginPage();
          },

          ),
        ),
      ),
    );
  }
}