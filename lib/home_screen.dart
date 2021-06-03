import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care/screens/login_screen.dart';

import 'business_logic/logout_cubit/logout_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = "/home_screen";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogoutCubit(),
      child: _HomeScreen(),
    );
  }
}

class _HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Home'),
            BlocConsumer<LogoutCubit, LogoutState>(
              bloc: BlocProvider.of<LogoutCubit>(context),
              builder: (context, state) {
                if (state is LogoutInitial)
                  return Center(
                    child: Text("InitialState"),
                  );
                else if (state is LogoutUnSuccessState)
                  return Center(
                    child: Text(state.message.toString().trim()),
                  );
                return Container();
              },
              listener: (context, state) {
                if (state is LogoutSuccessState) {
                  Navigator.pushAndRemoveUntil<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) => LoginScreen(),
                    ),
                    (route) =>
                        false, //if you want to disable back feature set to false
                  );
                }
              },
            ),
            ElevatedButton(
                onPressed: () => BlocProvider.of<LogoutCubit>(context).logOut(),
                child: Text('Sign out'))
          ],
        ),
      ),
    );
  }
}
