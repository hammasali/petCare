import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care/business_logic/auth_bloc/authentication_bloc.dart';
import 'package:pet_care/business_logic/chat_bloc/chat_bloc.dart';
import 'package:pet_care/core/routes.dart';
import 'package:pet_care/screens/main_screen/bottomNavTab.dart';

import 'business_logic/reg_bloc/reg_bloc.dart';
import 'screens/auth_screens/login_screen.dart';

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
      BlocProvider(
        create: (context) => ChatBloc(),
        lazy: true,
      ),
    ], child: MainApp());
  }
}

class MainApp extends StatefulWidget {
  MainApp({Key? key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final AppRoutes _appRoutes = AppRoutes();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      // routes: _appRoutes.routes,
      onGenerateRoute: _appRoutes.onGenerateRoute,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
        if (state is AuthenticateUser) return BottomNavBar(false);
        //return HomeScreen(isNewer: false,);

        return LoginScreen();
      }),
      //initialRoute: LoginScreen.routeName,
    );
  }

  @override
  void dispose() {
    _appRoutes.dispose();
    super.dispose();
  }
}
