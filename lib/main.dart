import "package:firebase_core/firebase_core.dart";
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sizer/sizer.dart';

// import 'package:pointr/classes/catalogue.dart';
// import 'package:pointr/classes/my_db.dart';
// import 'package:pointr/my_theme.dart';
// import 'package:pointr/providers/current_loc_provider.dart';
// import 'package:pointr/providers/from_provider.dart';
// import 'package:pointr/providers/nearby_provider.dart';
// import 'package:pointr/providers/route_provider.dart';
// import 'package:pointr/providers/search_suggestion_provider.dart';
// import 'package:pointr/providers/star_provider.dart';
// import 'package:pointr/providers/to_provider.dart';
// import 'package:pointr/screens/HomeScreen.dart';
// import 'package:pointr/screens/set_points_view_routes.dart';
// import 'package:pointr/widgets/bottom_nav_bar.dart';

import 'AllRouteBloc/AllRouteUI.dart';
import 'CustomRouteBloc/CustomRouteUI.dart';
import 'SuggestedRouteBloc/SuggestedRouteUI.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // MyDb.db = await MyDb.init();
  //Catalogue.loadRoutes();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();

    // return Sizer(
    //   builder: (context, orientation, deviceType) => MultiProvider(
    //     providers: [
    //       ChangeNotifierProvider(create: (context) => FromProvider()),
    //       ChangeNotifierProvider(create: (context) => ToProvider()),
    //       ChangeNotifierProvider(create: (context) => StarProvider()),
    //       ChangeNotifierProvider(create: (context) => RouteProvider()),
    //       ChangeNotifierProvider(
    //         create: (context) => SearchSuggestionProvider(),
    //       ),
    //       ChangeNotifierProvider(
    //         create: (context) => NearbyProvider(),
    //       ),
    //       ChangeNotifierProvider(
    //         create: (context) => CurrentLocProvider(),
    //       ),
    //     ],
    return MaterialApp(
      routes: {
        // "/": (context) => LoginPage(),
        // "/SignUp": (context) => SignUp(),
        "/suggestedRoute": (context) => SuggestedRouteUI(), //data_bloc_ui(),
        // "/Delete_User": (context) => DeleteUser(),
        // "/Update_user": (context) => UpdateUI(),
        // "/databloc": (context) => AddUI(),
        "/customRoute": (context) => CustomRouteUI(),
        "/AllRoute": (context) => AllRouteUI(),
      },
      title: 'Pointr',
      // theme: ThemeData(
      //   useMaterial3: true,
      //   textSelectionTheme: const TextSelectionThemeData(
      //     selectionColor: MyTheme.colorSecondary,
      //     selectionHandleColor: MyTheme.colorSecondary,
      //   ),
      //   primarySwatch: Colors.indigo,
      //   colorScheme: theme.colorScheme.copyWith(
      //     secondary: Colors.amber,
      //     background: Colors.white,
      //   ),
      //   fontFamily: 'Inter',
      //   textTheme: const TextTheme(
      //     bodyLarge: TextStyle(fontSize: 17),
      //   ),
      // ),
      initialRoute: "/customRoute",
    );
    //     ),
    //   ),
    // );
  }
}
