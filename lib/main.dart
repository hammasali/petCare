import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care/business_logic/auth_bloc/authentication_bloc.dart';
import 'package:pet_care/business_logic/logout_cubit/logout_cubit.dart';
import 'package:pet_care/core/routes.dart';

import 'business_logic/reg_bloc/reg_bloc.dart';
import 'home_screen.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<AuthenticationBloc>(
          create: (context) =>
              AuthenticationBloc()..add(AuthAppStartedEvent())),
      BlocProvider(
        create: (context) => RegBloc(),
        lazy: true,
      ),

    ], child: MainApp());
  }
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      routes: routes,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
        if (state is AuthenticateUser) return HomeScreen();

        return LoginScreen();
      }),
      //initialRoute: LoginScreen.routeName,
    );
  }
}
