import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care/about_pet_2.dart';
import 'package:pet_care/business_logic/appointment/appointment_bloc.dart';
import 'package:pet_care/business_logic/chat_bloc/chat_bloc.dart';
import 'package:pet_care/business_logic/logout_cubit/logout_cubit.dart';
import 'package:pet_care/business_logic/petdetails_bloc/pet_details_bloc.dart';
import 'package:pet_care/business_logic/reg_bloc/reg_bloc.dart';
import 'package:pet_care/core/global_variables.dart';
import 'package:pet_care/love_nest.dart';
import 'package:pet_care/screens/auth_screens/login_screen.dart';
import 'package:pet_care/screens/auth_screens/register_screen.dart';
import 'package:pet_care/screens/auth_screens/signIn_screen.dart';
import 'package:pet_care/screens/main_screen/bottomNavTab.dart';
import 'package:pet_care/screens/main_screen/explore/notifications_screen.dart';
import 'package:pet_care/screens/main_screen/search/home.dart';
import 'package:pet_care/screens/main_screen/search/my_pet/my_pet.dart';
import 'package:pet_care/screens/main_screen/search/pet_Date/about_pet.dart';
import 'package:pet_care/screens/main_screen/search/pet_Date/my_love_screen.dart';
import 'package:pet_care/screens/main_screen/search/pet_Sitter/add_pet_detail_screen.dart';
import 'package:pet_care/screens/main_screen/search/pet_chat/chat_home.dart';
import 'package:pet_care/screens/main_screen/search/pet_chat/messages_screen%20.dart';
import 'package:pet_care/screens/main_screen/search/pet_clinic/appointmentBooked.dart';
import 'package:pet_care/screens/main_screen/search/pet_clinic/search_clinic_screen.dart';
import 'package:pet_care/screens/main_screen/search/pet_shop/findBestProduct.dart';
import 'package:pet_care/screens/main_screen/search/pet_shop/pay.dart';
import 'package:pet_care/screens/main_screen/search/pet_shop/payment.dart';
import 'package:pet_care/screens/main_screen/search/pet_shop/product_detail_screen.dart';

class AppRoutes {
  final RegBloc _regBloc = RegBloc();
  final LogoutCubit _logoutCubit = LogoutCubit();
  final PetDetailsBloc _petDetailsCubit = PetDetailsBloc();
  final ChatBloc _chatBloc = ChatBloc();
  final AppointmentBloc _appointmentBloc = AppointmentBloc();

  Route? onGenerateRoute(RouteSettings routeSettings) {
    try {
      switch (routeSettings.name) {
        case LoginScreen.routeName:
          return MaterialPageRoute(builder: (_) => LoginScreen());
        case SignInScreen.routeName:
          return MaterialPageRoute(builder: (_) => SignInScreen());
        case RegisterScreen.routeName:
          return MaterialPageRoute(builder: (_) => RegisterScreen());

        case BottomNavBar.routeName:
          final args = routeSettings.arguments as Arguments;
          return MaterialPageRoute(
              builder: (_) => BottomNavBar(
                    args.isNewer,
                  ));

        case HomeScreen.routeName:
          final args = routeSettings.arguments as Arguments;
          return MaterialPageRoute(
              builder: (_) => HomeScreen(
                    isNewer: args.isNewer,
                  ));
        case SearchClinicScreen.routeName:
          return MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                    value: _appointmentBloc,
                    child: SearchClinicScreen(),
                  ));
        case AddPetDetailScreen.routeName:
          return MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                    value: _petDetailsCubit,
                    child: AddPetDetailScreen(),
                  ));
        case AppointmentBooked.routeName:
          return MaterialPageRoute(builder: (_) => AppointmentBooked());
        case ProductDetailScreen.routeName:
          return MaterialPageRoute(builder: (_) => ProductDetailScreen());
        case FindBestProduct.routeName:
          return MaterialPageRoute(builder: (_) => FindBestProduct());
        case PaymentScreen.routeName:
          return MaterialPageRoute(builder: (_) => PaymentScreen());

        case NotificationsScreen.routeName:
          return MaterialPageRoute(builder: (_) => NotificationsScreen());
        case MyLoveScreen.routeName:
          return MaterialPageRoute(builder: (_) => MyLoveScreen());
        case MessagesScreen.routeName:
          final args = routeSettings.arguments as ChatArgs;
          return MaterialPageRoute(builder: (_) => MessagesScreen(args));
        case ChatHome.routeName:
          return MaterialPageRoute(builder: (_) => ChatHome());
        case MyPet.routeName:
          return MaterialPageRoute(builder: (_) => MyPet());

        case AboutDog.routeName:
          final args = routeSettings.arguments as AboutPetArgs;
          return MaterialPageRoute(
              builder: (_) => AboutDog(
                    args: args,
                  ));

        case AboutPet2.routeName:
          return MaterialPageRoute(builder: (_) => AboutPet2());

        case LoveNest.routeName:
          return MaterialPageRoute(builder: (_) => LoveNest());

        case MySample.routeName:
          return MaterialPageRoute(builder: (_) => MySample());
        default:
          return null;
      }
    } catch (e) {
      print(e);
    }
  }

  // final Map<String, WidgetBuilder> routes = {
  //   // LoginScreen.routeName: (context) => LoginScreen(),
  //   SignInScreen.routeName: (context) => SignInScreen(),
  //   RegisterScreen.routeName: (context) => RegisterScreen(),
  //   HomeScreen.routeName: (context) => HomeScreen(),
  // };

  void dispose() {
    _regBloc.close();
    _logoutCubit.close();
    _chatBloc.close();
    _petDetailsCubit.close();
    _appointmentBloc.close();
  }
}

class AboutPetArgs {
  final String? name, size, breed, profilePhoto, heroTag, uid;

  AboutPetArgs({
    required this.name,
    required this.breed,
    required this.size,
    required this.profilePhoto,
    this.uid,
    required this.heroTag,
  });
}

class ChatArgs {
  final String? name, uid;

  ChatArgs({this.name, this.uid});
}
