import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care/business_logic/logout_cubit/logout_cubit.dart';
import 'package:pet_care/core/constants.dart';
import 'package:pet_care/core/global_variables.dart';
import 'package:pet_care/screens/auth_screens/login_screen.dart';
import 'package:pet_care/screens/main_screen/search/pet_chat/chat_home.dart';
import 'package:pet_care/screens/main_screen/search/pet_Date/my_love_screen.dart';
import 'package:pet_care/screens/main_screen/search/pet_Sitter/add_pet_detail_screen.dart';
import 'package:pet_care/screens/main_screen/search/pet_clinic/selectSpecialist.dart';
import 'package:pet_care/screens/main_screen/search/pet_shop/findBestProduct.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'my_pet/my_pet.dart';

class HomeScreen extends StatelessWidget {
  final bool isNewer;

  const HomeScreen({Key? key, required this.isNewer}) : super(key: key);
  static const String routeName = "/home_screen";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogoutCubit(),
      child: home(
        isNewer: isNewer,
      ),
    );
  }
}

// ignore: camel_case_types
class home extends StatefulWidget {
  final bool isNewer;

  const home({Key? key, required this.isNewer}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _homeState();
  }
}

// ignore: camel_case_types
class _homeState extends State<home> {
  var active_item_index = 0;
  var selectedIndex = 0;
  late SharedPreferences prefs;
  String? name;

  void initState() {
    super.initState();
    _prefrences();
    if (widget.isNewer == true) {
      _addPetDetails();
    }
  }

  Widget get _actionDialog => FittedBox(
        fit: BoxFit.scaleDown,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Image.asset(
              'assets/images/dog_placeholder.png',
              color: Colors.blueGrey,
            ),
            RichText(
              text: new TextSpan(
                // Note: Styles for TextSpans must be explicitly defined.
                // Child text spans will inherit styles from parent
                style: new TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 30.0),
                children: <TextSpan>[
                  new TextSpan(
                      text: 'ADD',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 50.0)),
                  TextSpan(
                    text: ' pet details?',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.solidCircle,
                      size: 10.0,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Faster check-in at appointment.",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          decoration: TextDecoration.none),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.0,
                ),
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.solidCircle,
                      size: 10.0,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Reminder of the upcoming events\nwith your pets.",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          decoration: TextDecoration.none),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.0,
                ),
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.solidCircle,
                      size: 10.0,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Schedule of vaccination, inspection,\nhaircuts etc.",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          decoration: TextDecoration.none),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context)
                      .popAndPushNamed(AddPetDetailScreen.routeName),
                  child: Container(
                      padding: EdgeInsets.all(kDefaultPadding),
                      decoration: BoxDecoration(
                        color: Color(0xFF84AAF0),
                        border: Border.all(color: Colors.black45),
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Text(
                        '+ Add',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            decoration: TextDecoration.none),
                      )),
                ),
                SizedBox(
                  width: 80.0,
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                      padding: EdgeInsets.all(kDefaultPadding),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black45),
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Text(
                        'No,later',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                            decoration: TextDecoration.none),
                      )),
                )
              ],
            ),
          ],
        ),
      );

  get _actionDialog2 => Stack(
        children: <Widget>[
          Center(
            child: Container(
              height: 300,
              margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
              decoration: BoxDecoration(
                color: kDefaultBackgroundColor,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 50.0,
                  ),
                  Center(
                    child: Material(
                      shadowColor: kDefaultBackgroundColor,
                      color: kDefaultBackgroundColor,
                      child: Text(
                        'Pet Date',
                        style: GoogleFonts.laila(
                          textStyle: TextStyle(
                            fontSize: 24,
                            color: const Color(0xff181818),
                          ),
                        ),
                        textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: false),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40.0),
                        bottomRight: Radius.circular(40.0)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Container(
                              height: 80,
                              color: Color(0xff262626),
                              child: Material(
                                color: Color(0xff262626),
                                child: Center(
                                  child: Text(
                                    'Later',
                                    style: GoogleFonts.laila(
                                      textStyle: TextStyle(
                                        fontSize: 20,
                                        color: const Color(0xffffffff),
                                      ),
                                    ),
                                    textHeightBehavior: TextHeightBehavior(
                                        applyHeightToFirstAscent: false),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Navigator.of(context)
                                .pushNamed(MyLoveScreen.routeName),
                            child: Container(
                              height: 80,
                              color: Color(0xfffD705E),
                              child: Material(
                                color: Color(0xfffD705E),
                                child: Center(
                                  child: Text(
                                    'Take Tour',
                                    style: GoogleFonts.laila(
                                      textStyle: TextStyle(
                                        fontSize: 20,
                                        color: const Color(0xffffffff),
                                      ),
                                    ),
                                    textHeightBehavior: TextHeightBehavior(
                                        applyHeightToFirstAscent: false),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 150.0,
            left: 50.0,
            right: 50.0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                    color: const Color(0x66fd705e),
                  ),
                ),
                Container(
                  width: 125.0,
                  height: 125.0,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                    color: const Color(0x99fd705e),
                  ),
                ),
                Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                    color: const Color(0xfffd705e),
                  ),
                ),
                Container(
                  width: 50.0,
                  height: 50.0,
                  child: SvgPicture.string(
                    '<svg viewBox="329.0 388.0 92.0 80.0" ><path  d="M 393.0098876953125 388 C 386.67041015625 388 380.7110900878906 390.0672912597656 375.7756958007812 393.9804077148438 C 375.7756958007812 393.9804077148438 375.0003967285156 394.5964050292969 375.0003967285156 394.5964050292969 C 375.0003967285156 394.5964050292969 374.2235107421875 393.9797973632812 374.2235107421875 393.9797973632812 C 369.2901000976562 390.0672912597656 363.3315124511719 388 356.9927978515625 388 C 348.9764099121094 388 341.7356872558594 391.4212951660156 336.6272888183594 396.8918151855469 C 338.7219848632812 397.9150085449219 343.5028991699219 399.5694885253906 353.0939025878906 400.0508117675781 C 355.4028930664062 400.1669006347656 362.2213134765625 400.5957946777344 362.59228515625 400.6827087402344 C 363.0083923339844 400.7327880859375 363.5404052734375 400.9031066894531 363.5736083984375 401.3346862792969 C 363.7184143066406 403.29541015625 361.9527893066406 404.1606140136719 360.5444030761719 404.2070007324219 C 359.4403076171875 404.2431945800781 353.7109985351562 404.0546875 352.7839965820312 405.7857055664062 C 352.3608093261719 406.5739135742188 354.6745910644531 408.4299011230469 355.3927001953125 409.1097106933594 C 356.2869873046875 409.9577026367188 357.1834106445312 410.8052062988281 358.0799865722656 411.652587890625 C 360.5238037109375 413.9634094238281 363.0491027832031 416.351806640625 365.5169982910156 418.7186889648438 C 366.0201110839844 419.2012939453125 367.9981079101562 421.2717895507812 366.9674987792969 422.3124084472656 C 365.9364013671875 423.3528137207031 363.9104919433594 421.6263122558594 363.1953125 420.95458984375 C 361.3622131347656 419.23291015625 354.8168029785156 413.6319885253906 354.5516967773438 413.8699035644531 C 354.5516967773438 413.8699035644531 354.52880859375 413.89111328125 354.52880859375 413.89111328125 C 354.2215881347656 414.2016906738281 364.4881896972656 424.4718017578125 364.4881896972656 424.4718017578125 C 364.4881896972656 424.4718017578125 367.5791015625 427.3800048828125 366.4223937988281 428.547607421875 C 365.2652893066406 429.7157897949219 362.3847961425781 426.8971862792969 361.6854858398438 426.2385864257812 C 359.4613037109375 424.1491088867188 351.423095703125 417.1409912109375 351.1712951660156 417.3948059082031 C 350.9941101074219 417.5776977539062 358.1286010742188 425.1242065429688 360.260986328125 427.1843872070312 C 361.0068054199219 427.906494140625 363.4786987304688 430.330810546875 362.4031066894531 431.4161987304688 C 361.32861328125 432.5025939941406 358.7940063476562 430.2059020996094 358.1665954589844 429.6199951171875 C 356.1640930175781 427.75048828125 348.0873107910156 420.819091796875 347.910888671875 420.9966125488281 C 347.910888671875 420.9966125488281 347.8958129882812 421.0118103027344 347.8958129882812 421.0118103027344 C 347.7152099609375 421.2008056640625 352.5217895507812 426.5477905273438 354.4619140625 428.3877868652344 C 355.0361938476562 428.9305114746094 355.6099853515625 429.5390930175781 355.9208068847656 430.302490234375 C 356.2298889160156 431.0614929199219 356.2155151367188 431.5256958007812 355.8699035644531 431.9053039550781 C 355.8576049804688 431.9197998046875 355.8443908691406 431.9324035644531 355.8310852050781 431.9457092285156 C 355.4580078125 432.322509765625 354.9418029785156 432.368408203125 354.2984924316406 432.0827026367188 C 353.5458984375 431.7475891113281 352.9367980957031 431.3648071289062 352.4905090332031 430.9457092285156 C 347.7311096191406 426.4840087890625 343.7756042480469 422.8882141113281 340.2927856445312 419.3720092773438 C 338.7955932617188 417.8620910644531 337.1834106445312 413.8958129882812 335.5566101074219 410.8587951660156 C 334.5875854492188 409.0498962402344 332.4472961425781 407.2511901855469 330.8746948242188 406.0924987792969 C 329.6640014648438 409.2484130859375 328.9999084472656 412.6755065917969 328.9999084472656 416.2572937011719 C 328.9999084472656 436.8416137695312 344.18798828125 447.1398010253906 356.3953857421875 455.4154052734375 C 361.3642883300781 458.7824096679688 366.0556945800781 461.9668884277344 369.1051025390625 465.3843994140625 C 370.589111328125 467.0481872558594 372.7041015625 468 374.9218139648438 468 C 374.9296875 468 374.935791015625 468 374.94140625 468 C 377.168212890625 467.9934997558594 379.2844848632812 467.0320129394531 380.7640991210938 465.3540954589844 C 383.7453002929688 461.9779052734375 388.4350891113281 458.8052978515625 393.4021911621094 455.4454040527344 C 395.1301879882812 454.2752990722656 396.9176025390625 453.0654907226562 398.7138977050781 451.7940979003906 C 397.6025085449219 450.1948852539062 395.6246948242188 447.6476135253906 393.6318969726562 446.5606079101562 C 390.6239929199219 444.9184875488281 386.6943969726562 443.2898864746094 385.1983032226562 441.7799987792969 C 381.7153015136719 438.2641906738281 378.1524047851562 434.2716064453125 373.7319030761719 429.46728515625 C 373.3179016113281 429.0155029296875 372.9388122558594 428.4010925292969 372.606689453125 427.64111328125 C 372.3226013183594 426.9917907714844 372.3678894042969 426.4714050292969 372.7412109375 426.0942993164062 C 372.7546081542969 426.0813903808594 372.7680969238281 426.068603515625 372.7813110351562 426.0551147460938 C 373.1575012207031 425.7069091796875 373.6170043945312 425.6921997070312 374.3705139160156 426.00439453125 C 375.1253051757812 426.3186950683594 375.7284851074219 426.8978881835938 376.2676086425781 427.4764099121094 C 378.0885925292969 429.4361877441406 383.3865966796875 434.2878112792969 383.5737915039062 434.1041870117188 C 383.5737915039062 434.1041870117188 383.5887145996094 434.089111328125 383.5887145996094 434.089111328125 C 383.7636108398438 433.9122009277344 376.8970947265625 425.7580871582031 375.0451965332031 423.7374877929688 C 374.464599609375 423.1041870117188 372.1896057128906 420.5465087890625 373.2658081054688 419.4606018066406 C 374.3411865234375 418.3752136230469 376.7427978515625 420.8706970214844 377.4587097167969 421.6242065429688 C 379.4986877441406 423.7760009765625 386.97509765625 430.977294921875 387.1567993164062 430.7983093261719 C 387.40771484375 430.5452880859375 380.4652099609375 422.4301147460938 378.3958129882812 420.1863098144531 C 377.7424011230469 419.4800109863281 374.9512023925781 416.5715942382812 376.1072082519531 415.40478515625 C 377.2644958496094 414.2369079589844 380.1459045410156 417.3568115234375 380.1459045410156 417.3568115234375 C 380.1459045410156 417.3568115234375 390.3192138671875 427.7193908691406 390.6270141601562 427.4096984863281 C 390.6270141601562 427.4096984863281 390.6484985351562 427.3865051269531 390.6484985351562 427.3865051269531 C 390.8840026855469 427.1182861328125 385.3349914550781 420.5118103027344 383.6294860839844 418.6614990234375 C 382.9643859863281 417.9397888183594 381.2532958984375 415.8948059082031 382.2844848632812 414.8539123535156 C 383.3150024414062 413.81298828125 385.3678894042969 415.8100891113281 385.8446960449219 416.3186950683594 C 388.1896057128906 418.8092041015625 390.556396484375 421.3590087890625 392.8456115722656 423.8250122070312 C 393.6842041015625 424.7300109863281 394.5246887207031 425.6343078613281 395.364013671875 426.5382995605469 C 396.03759765625 427.2622985839844 397.8770141601562 429.5986938476562 398.6574096679688 429.1715087890625 C 400.3717956542969 428.2347106933594 400.1849975585938 422.4526062011719 400.2217102050781 421.3370056152344 C 400.2674865722656 419.9151916503906 401.1241149902344 418.1329956054688 403.0667114257812 418.2803955078125 C 403.4945983886719 418.3125915527344 403.6625061035156 418.8508911132812 403.7131958007812 419.2705078125 C 403.7994079589844 419.6451110839844 404.2239990234375 426.5274047851562 404.3392944335938 428.8587036132812 C 404.7851867675781 437.9229125976562 406.2510070800781 442.7315063476562 407.2673950195312 445.04150390625 C 414.8774108886719 438.1398010253906 420.9997863769531 429.2297058105469 420.9997863769531 416.2576904296875 C 421.0000915527344 400.676513671875 408.444091796875 388 393.0098876953125 388 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>',
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),
          // Pinned.fromPins(
          //   Pin(size: 234.0, middle: 0.5011),
          //   Pin(size: 234.0, start: 0.0),
          //   child:
          //   // Adobe XD layer: 'Ellipse 5' (shape)
          //   Container(
          //     decoration: BoxDecoration(
          //       borderRadius:
          //       BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
          //       color: const Color(0x66fd705e),
          //     ),
          //   ),
          // ),
          // Pinned.fromPins(
          //   Pin(size: 198.1, middle: 0.501),
          //   Pin(size: 198.1, start: 17.9),
          //   child:
          //   // Adobe XD layer: 'Ellipse 5 copy 2' (shape)
          //   Container(
          //     decoration: BoxDecoration(
          //       borderRadius:
          //       BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
          //       color: const Color(0x99fd705e),
          //     ),
          //   ),
          // ),
          // Pinned.fromPins(
          //   Pin(size: 159.1, middle: 0.501),
          //   Pin(size: 159.1, start: 37.4),
          //   child:
          //   // Adobe XD layer: 'Ellipse 5 copy' (shape)
          //   Container(
          //     decoration: BoxDecoration(
          //       borderRadius:
          //       BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
          //       color: const Color(0xfffd705e),
          //     ),
          //   ),
          // ),
          // Pinned.fromPins(
          //   Pin(size: 92.0, middle: 0.4991),
          //   Pin(size: 80.0, start: 77.0),
          //   child:
          //   // Adobe XD layer: 'Forma 1' (shape)
          //   SvgPicture.string(
          //     '<svg viewBox="329.0 388.0 92.0 80.0" ><path  d="M 393.0098876953125 388 C 386.67041015625 388 380.7110900878906 390.0672912597656 375.7756958007812 393.9804077148438 C 375.7756958007812 393.9804077148438 375.0003967285156 394.5964050292969 375.0003967285156 394.5964050292969 C 375.0003967285156 394.5964050292969 374.2235107421875 393.9797973632812 374.2235107421875 393.9797973632812 C 369.2901000976562 390.0672912597656 363.3315124511719 388 356.9927978515625 388 C 348.9764099121094 388 341.7356872558594 391.4212951660156 336.6272888183594 396.8918151855469 C 338.7219848632812 397.9150085449219 343.5028991699219 399.5694885253906 353.0939025878906 400.0508117675781 C 355.4028930664062 400.1669006347656 362.2213134765625 400.5957946777344 362.59228515625 400.6827087402344 C 363.0083923339844 400.7327880859375 363.5404052734375 400.9031066894531 363.5736083984375 401.3346862792969 C 363.7184143066406 403.29541015625 361.9527893066406 404.1606140136719 360.5444030761719 404.2070007324219 C 359.4403076171875 404.2431945800781 353.7109985351562 404.0546875 352.7839965820312 405.7857055664062 C 352.3608093261719 406.5739135742188 354.6745910644531 408.4299011230469 355.3927001953125 409.1097106933594 C 356.2869873046875 409.9577026367188 357.1834106445312 410.8052062988281 358.0799865722656 411.652587890625 C 360.5238037109375 413.9634094238281 363.0491027832031 416.351806640625 365.5169982910156 418.7186889648438 C 366.0201110839844 419.2012939453125 367.9981079101562 421.2717895507812 366.9674987792969 422.3124084472656 C 365.9364013671875 423.3528137207031 363.9104919433594 421.6263122558594 363.1953125 420.95458984375 C 361.3622131347656 419.23291015625 354.8168029785156 413.6319885253906 354.5516967773438 413.8699035644531 C 354.5516967773438 413.8699035644531 354.52880859375 413.89111328125 354.52880859375 413.89111328125 C 354.2215881347656 414.2016906738281 364.4881896972656 424.4718017578125 364.4881896972656 424.4718017578125 C 364.4881896972656 424.4718017578125 367.5791015625 427.3800048828125 366.4223937988281 428.547607421875 C 365.2652893066406 429.7157897949219 362.3847961425781 426.8971862792969 361.6854858398438 426.2385864257812 C 359.4613037109375 424.1491088867188 351.423095703125 417.1409912109375 351.1712951660156 417.3948059082031 C 350.9941101074219 417.5776977539062 358.1286010742188 425.1242065429688 360.260986328125 427.1843872070312 C 361.0068054199219 427.906494140625 363.4786987304688 430.330810546875 362.4031066894531 431.4161987304688 C 361.32861328125 432.5025939941406 358.7940063476562 430.2059020996094 358.1665954589844 429.6199951171875 C 356.1640930175781 427.75048828125 348.0873107910156 420.819091796875 347.910888671875 420.9966125488281 C 347.910888671875 420.9966125488281 347.8958129882812 421.0118103027344 347.8958129882812 421.0118103027344 C 347.7152099609375 421.2008056640625 352.5217895507812 426.5477905273438 354.4619140625 428.3877868652344 C 355.0361938476562 428.9305114746094 355.6099853515625 429.5390930175781 355.9208068847656 430.302490234375 C 356.2298889160156 431.0614929199219 356.2155151367188 431.5256958007812 355.8699035644531 431.9053039550781 C 355.8576049804688 431.9197998046875 355.8443908691406 431.9324035644531 355.8310852050781 431.9457092285156 C 355.4580078125 432.322509765625 354.9418029785156 432.368408203125 354.2984924316406 432.0827026367188 C 353.5458984375 431.7475891113281 352.9367980957031 431.3648071289062 352.4905090332031 430.9457092285156 C 347.7311096191406 426.4840087890625 343.7756042480469 422.8882141113281 340.2927856445312 419.3720092773438 C 338.7955932617188 417.8620910644531 337.1834106445312 413.8958129882812 335.5566101074219 410.8587951660156 C 334.5875854492188 409.0498962402344 332.4472961425781 407.2511901855469 330.8746948242188 406.0924987792969 C 329.6640014648438 409.2484130859375 328.9999084472656 412.6755065917969 328.9999084472656 416.2572937011719 C 328.9999084472656 436.8416137695312 344.18798828125 447.1398010253906 356.3953857421875 455.4154052734375 C 361.3642883300781 458.7824096679688 366.0556945800781 461.9668884277344 369.1051025390625 465.3843994140625 C 370.589111328125 467.0481872558594 372.7041015625 468 374.9218139648438 468 C 374.9296875 468 374.935791015625 468 374.94140625 468 C 377.168212890625 467.9934997558594 379.2844848632812 467.0320129394531 380.7640991210938 465.3540954589844 C 383.7453002929688 461.9779052734375 388.4350891113281 458.8052978515625 393.4021911621094 455.4454040527344 C 395.1301879882812 454.2752990722656 396.9176025390625 453.0654907226562 398.7138977050781 451.7940979003906 C 397.6025085449219 450.1948852539062 395.6246948242188 447.6476135253906 393.6318969726562 446.5606079101562 C 390.6239929199219 444.9184875488281 386.6943969726562 443.2898864746094 385.1983032226562 441.7799987792969 C 381.7153015136719 438.2641906738281 378.1524047851562 434.2716064453125 373.7319030761719 429.46728515625 C 373.3179016113281 429.0155029296875 372.9388122558594 428.4010925292969 372.606689453125 427.64111328125 C 372.3226013183594 426.9917907714844 372.3678894042969 426.4714050292969 372.7412109375 426.0942993164062 C 372.7546081542969 426.0813903808594 372.7680969238281 426.068603515625 372.7813110351562 426.0551147460938 C 373.1575012207031 425.7069091796875 373.6170043945312 425.6921997070312 374.3705139160156 426.00439453125 C 375.1253051757812 426.3186950683594 375.7284851074219 426.8978881835938 376.2676086425781 427.4764099121094 C 378.0885925292969 429.4361877441406 383.3865966796875 434.2878112792969 383.5737915039062 434.1041870117188 C 383.5737915039062 434.1041870117188 383.5887145996094 434.089111328125 383.5887145996094 434.089111328125 C 383.7636108398438 433.9122009277344 376.8970947265625 425.7580871582031 375.0451965332031 423.7374877929688 C 374.464599609375 423.1041870117188 372.1896057128906 420.5465087890625 373.2658081054688 419.4606018066406 C 374.3411865234375 418.3752136230469 376.7427978515625 420.8706970214844 377.4587097167969 421.6242065429688 C 379.4986877441406 423.7760009765625 386.97509765625 430.977294921875 387.1567993164062 430.7983093261719 C 387.40771484375 430.5452880859375 380.4652099609375 422.4301147460938 378.3958129882812 420.1863098144531 C 377.7424011230469 419.4800109863281 374.9512023925781 416.5715942382812 376.1072082519531 415.40478515625 C 377.2644958496094 414.2369079589844 380.1459045410156 417.3568115234375 380.1459045410156 417.3568115234375 C 380.1459045410156 417.3568115234375 390.3192138671875 427.7193908691406 390.6270141601562 427.4096984863281 C 390.6270141601562 427.4096984863281 390.6484985351562 427.3865051269531 390.6484985351562 427.3865051269531 C 390.8840026855469 427.1182861328125 385.3349914550781 420.5118103027344 383.6294860839844 418.6614990234375 C 382.9643859863281 417.9397888183594 381.2532958984375 415.8948059082031 382.2844848632812 414.8539123535156 C 383.3150024414062 413.81298828125 385.3678894042969 415.8100891113281 385.8446960449219 416.3186950683594 C 388.1896057128906 418.8092041015625 390.556396484375 421.3590087890625 392.8456115722656 423.8250122070312 C 393.6842041015625 424.7300109863281 394.5246887207031 425.6343078613281 395.364013671875 426.5382995605469 C 396.03759765625 427.2622985839844 397.8770141601562 429.5986938476562 398.6574096679688 429.1715087890625 C 400.3717956542969 428.2347106933594 400.1849975585938 422.4526062011719 400.2217102050781 421.3370056152344 C 400.2674865722656 419.9151916503906 401.1241149902344 418.1329956054688 403.0667114257812 418.2803955078125 C 403.4945983886719 418.3125915527344 403.6625061035156 418.8508911132812 403.7131958007812 419.2705078125 C 403.7994079589844 419.6451110839844 404.2239990234375 426.5274047851562 404.3392944335938 428.8587036132812 C 404.7851867675781 437.9229125976562 406.2510070800781 442.7315063476562 407.2673950195312 445.04150390625 C 414.8774108886719 438.1398010253906 420.9997863769531 429.2297058105469 420.9997863769531 416.2576904296875 C 421.0000915527344 400.676513671875 408.444091796875 388 393.0098876953125 388 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>',
          //     allowDrawingOutsideViewBox: true,
          //     fit: BoxFit.fill,
          //   ),
          // ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogoutCubit, LogoutState>(
      listener: (context, state) {
        if (state is LogoutSuccessState) {
          Navigator.pushAndRemoveUntil<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => LoginScreen(),
            ),
            (route) => false, //if you want to disable back feature set to false
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFECE7D8),
          actions: [
            IconButton(
              onPressed: () => BlocProvider.of<LogoutCubit>(context).logOut(),
              tooltip: 'Log out',
              icon: Icon(
                Icons.logout,
                color: Colors.deepPurpleAccent,
              ),
            ),
            new Text('   '),
          ],
          elevation: 0,
        ),
        body: new Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFECE7D8),
                    Color(0xFFD7C8A1),
                    Color(0xFFD7C8A1),
                    Color(0xFFECE7D8),
                  ],
                  stops: [0.1, 0.4, 0.7, 0.9],
                ),
              ),
            ),
            new ListView(
              children: <Widget>[
                new SizedBox(
                  height: 20,
                ),
                new SizedBox(
                  height: 30,
                ),
                new Padding(
                  padding: EdgeInsets.all(30.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Padding(
                          padding: EdgeInsets.all(10.0),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: new RichText(
                              text: new TextSpan(
                                // Note: Styles for TextSpans must be explicitly defined.
                                // Child text spans will inherit styles from parent
                                style: new TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 30.0),
                                children: <TextSpan>[
                                  new TextSpan(
                                      text: 'What are you\n looking for,'),
                                  TextSpan(
                                      text: ' $name?',
                                      style: new TextStyle(color: Colors.blue)),
                                ],
                              ),
                            ),
                          )),
                      new SizedBox(
                        height: 20,
                      ),
                      new GridView.count(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(10.0),
                          crossAxisCount: 3,
                          physics: ScrollPhysics(),
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                          children: <Widget>[
                            new Column(
                              children: <Widget>[
                                //====================PET CLINIC================
                                new GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        enableDrag: true,
                                        elevation: 1.1,
                                        isScrollControlled: true,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(30.0))),
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        backgroundColor: Color(0xFFDECEB5),
                                        builder: (context) =>
                                            SelectSpecialist());
                                  },
                                  child: new Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(26.0)),
                                      ),
                                      width: 80,
                                      height: 80,
                                      padding: EdgeInsets.all(8),
                                      child: new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/images/CompositeLayer@1X (5).png",
                                          ),
                                          new Divider(
                                            color: Colors.white,
                                            height: 10,
                                          ),
                                          new Text('Pet clinic',
                                              textAlign: TextAlign.center,
                                              style: Style.globalTextStyle),
                                        ],
                                      )),
                                ),
                              ],
                            ),

                            //====================Chat ================
                            new Column(
                              children: <Widget>[
                                new GestureDetector(
                                  onTap: () => Navigator.of(context)
                                      .pushNamed(ChatHome.routeName),
                                  child: new Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(26.0)),
                                      ),
                                      width: 80,
                                      height: 80,
                                      padding: EdgeInsets.all(8),
                                      child: new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/images/CompositeLayer@1X (4).png",
                                          ),
                                          new Divider(
                                            color: Colors.white,
                                            height: 10,
                                          ),
                                          new Text('Chat',
                                              textAlign: TextAlign.center,
                                              style: Style.globalTextStyle),
                                        ],
                                      )),
                                ),
                              ],
                            ),

                            //====================Pet Sitter================

                            new Column(
                              children: <Widget>[
                                new GestureDetector(
                                  onTap: () => _showDialog(),
                                  child: new Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(26.0)),
                                      ),
                                      width: 80,
                                      height: 80,
                                      padding: EdgeInsets.all(8.0),
                                      child: new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/images/CompositeLayer@1X (3).png",
                                          ),
                                          new Divider(
                                            color: Colors.white,
                                            height: 10,
                                          ),
                                          new Text('Pet Sitter',
                                              textAlign: TextAlign.center,
                                              style: Style.globalTextStyle),
                                        ],
                                      )),
                                ),
                              ],
                            ),

                            //====================Training================

                            new Column(
                              children: <Widget>[
                                new GestureDetector(
                                  onTap: () => Navigator.of(context)
                                      .pushNamed(MyPet.routeName),
                                  child: new Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(26.0)),
                                      ),
                                      width: 80,
                                      height: 80,
                                      padding: EdgeInsets.all(8),
                                      child: new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/images/CompositeLayer@1X.png",
                                          ),
                                          new Divider(
                                            color: Colors.white,
                                            height: 10,
                                          ),
                                          new Text('My Pet',
                                              textAlign: TextAlign.center,
                                              style: Style.globalTextStyle),
                                        ],
                                      )),
                                ),
                              ],
                            ),

                            //====================Pet Date================
                            new Column(
                              children: <Widget>[
                                new GestureDetector(
                                  onTap: () => _showDialog2(),
                                  child: new Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(26.0)),
                                      ),
                                      width: 80,
                                      height: 80,
                                      padding: EdgeInsets.all(8),
                                      child: new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/images/CompositeLayer@1X (1).png",
                                          ),
                                          new Divider(
                                            color: Colors.white,
                                            height: 10,
                                          ),
                                          new Text('Pet Date',
                                              textAlign: TextAlign.center,
                                              style: Style.globalTextStyle),
                                        ],
                                      )),
                                ),
                              ],
                            ),

                            //================== Pet Shop===================
                            new Column(
                              children: <Widget>[
                                new GestureDetector(
                                  onTap: () => Navigator.of(context)
                                      .pushNamed(FindBestProduct.routeName),
                                  child: new Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(26.0)),
                                      ),
                                      width: 80,
                                      height: 80,
                                      padding: EdgeInsets.all(8),
                                      child: new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/images/CompositeLayer@1X (2)(1).png",
                                          ),
                                          new Divider(
                                            color: Colors.white,
                                            height: 10,
                                          ),
                                          new Text('Pet Shop',
                                              textAlign: TextAlign.center,
                                              style: Style.globalTextStyle),
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          ]),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
        // bottomNavigationBar: new Container(
        //   height: 65,
        //   child: BottomNavBar(),
        // )
      ),
    );
  }

  void on_Item_clicked(i) {
    setState(() {
      active_item_index = i;
    });
  }

  void _prefrences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name');
    });
  }

  void _addPetDetails() {
    Future.delayed(Duration(seconds: 5), () {
      _showDialog();
    });
  }

  void _showDialog() {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.all(kDefaultPadding),
            height: 300,
            child: SizedBox.expand(child: _actionDialog),
            margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
            decoration: BoxDecoration(
              color: kDefaultBackgroundColor,
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  void _showDialog2() {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: SizedBox.expand(child: _actionDialog2),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }
}

//TODO: LogoutCubit

//children: [
// Text('Home'),
// BlocConsumer<LogoutCubit, LogoutState>(
// bloc: BlocProvider.of<LogoutCubit>(context),
// builder: (context, state) {
// if (state is LogoutInitial)
// return Center(
// child: Text("InitialState"),
// );
// else if (state is LogoutUnSuccessState)
// return Center(
// child: Text(state.message.toString().trim()),
// );
// return Container();
// },
// listener: (context, state) {
// if (state is LogoutSuccessState) {
// Navigator.pushAndRemoveUntil<dynamic>(
// context,
// MaterialPageRoute<dynamic>(
// builder: (BuildContext context) => LoginScreen(),
// ),
// (route) =>
// false, //if you want to disable back feature set to false
// );
// }
// },
// ),
// ElevatedButton(
// onPressed: () => BlocProvider.of<LogoutCubit>(context).logOut(),
// child: Text('Sign out'))
// ]
