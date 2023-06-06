import 'package:firebase_auth/firebase_auth.dart';
import "package:firebase_core/firebase_core.dart";
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sizer/sizer.dart';

// import 'package:pointr/classes/catalogue.dart';
import 'package:pointr/classes/my_db.dart';
import 'package:pointr/providers/current_loc_provider.dart';
import 'package:pointr/providers/from_provider.dart';
import 'package:pointr/providers/nearby_provider.dart';
import 'package:pointr/providers/route_provider.dart';
import 'package:pointr/providers/search_suggestion_provider.dart';
import 'package:pointr/providers/star_provider.dart';
import 'package:pointr/providers/to_provider.dart';
import 'package:pointr/screens/HomeScreen.dart';
import 'package:pointr/screens/NewLogin.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'AllRouteBloc/AllRouteUI.dart';
import 'CustomRouteBloc/CustomRouteUI.dart';
import 'SuggestedRouteBloc/SuggestedRouteUI.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MyDb.db = await MyDb.init();
  //Catalogue.loadRoutes();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();

    return Sizer(
      builder: (context, orientation, deviceType) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => FromProvider()),
          ChangeNotifierProvider(create: (context) => ToProvider()),
          ChangeNotifierProvider(create: (context) => StarProvider()),
          ChangeNotifierProvider(create: (context) => RouteProvider()),
          ChangeNotifierProvider(
            create: (context) => SearchSuggestionProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => NearbyProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => CurrentLocProvider(),
          ),
        ],
        child: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) => MaterialApp(
                  routes: {
                    "/login": (context) => const Login(),
                    "/suggestedRoute": (context) =>
                        const SuggestedRouteUI(), //data_bloc_ui(),
                    "/customRoute": (context) => const CustomRouteUI(),
                    "/AllRoute": (context) => const AllRouteUI(),
                    "/navbar": (context) => const HomeScreen(),
                  },
                  title: 'Pointr',
                  initialRoute: snapshot.data == null ? "/login" : "/navbar",
                  // home: const BNavScaffold(index: 0),
                )),
      ),
    );
    //     ),
    //   ),
    // );
  }
}
