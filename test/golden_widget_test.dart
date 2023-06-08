import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:naj_ul_balagha/InApplication/Bloc_Balagha_text/Pages/ReadingPage.dart';
// import 'package:naj_ul_balagha/InApplication/Bloc_Balagha_toc/Pages/IndexedPage.dart';
// import 'package:naj_ul_balagha/InApplication/Bloc_Balagha_toc/balaghatocbloc.dart';
// import 'package:naj_ul_balagha/InApplication/Bookmarks/Pages/BookmarksView.dart';
// import 'package:naj_ul_balagha/InApplication/Hawashi/Pages/HawashiView.dart';
// import 'package:naj_ul_balagha/InApplication/HomePage.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:mockito/mockito.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:pointr/AllRouteBloc/AllRouteUI.dart';
import 'package:pointr/CustomRouteBloc/CustomRouteUI.dart';
import 'package:pointr/SuggestedRouteBloc/SuggestedRouteUI.dart';
import 'package:pointr/screens/HomeScreen.dart';
import 'package:pointr/screens/NewLogin.dart';
import 'package:pointr/widgets/Add_Route.dart';
// import 'package:naj_ul_balagha/InApplication/Muqadmat/Pages/PaishGhuftar.dart';
// import 'package:naj_ul_balagha/InApplication/Muqadmat/Pages/RPHurf-e-Agas.dart';
// import 'package:naj_ul_balagha/InApplication/Notes/pages/NotesUpdate.dart';
// import 'package:naj_ul_balagha/InApplication/Notes/pages/NotesView.dart';
// import 'package:naj_ul_balagha/InApplication/ProfileOptions.dart';
// import 'package:naj_ul_balagha/InApplication/UpdateUser.dart';
// import 'package:naj_ul_balagha/OnBoarding/Login.dart';
// import 'package:naj_ul_balagha/OnBoarding/Signup.dart';
// import 'package:naj_ul_balagha/InApplication/Notes/pages/NoteAdd.dart';
// import 'package:naj_ul_balagha/OnBoarding/bloc/UserBloc.dart';
// import 'package:naj_ul_balagha/OnBoarding/bloc/UserStates.dart';
// import 'package:naj_ul_balagha/OnBoarding/bloc/UserRepo.dart';
// import 'package:naj_ul_balagha/main.dart';
// import 'BlocTesting/BalaghatextBloc_test/MockBalaghaTextRepo.dart';
// import 'BlocTesting/BookmarkBloc_test/MockBookmarkRepo.dart';
// import 'BlocTesting/HawashiBloc_test/MockHawashiRep.dart';
// import 'BlocTesting/Muqadamat_test/MockMuqadamatRepo.dart';
// import 'BlocTesting/Notes_test/MockNoteRepo.dart';
// import 'BlocTesting/UserBlocTest/MockUserRepo.dart';
import 'BlocTesting/AllRoutesBlocTest/MockAllRoutesTestRepo.dart';
import 'BlocTesting/CustomRouteBlocTest/MockCustomRouteTestRepo.dart';
import 'BlocTesting/SuggestedRouteBlocTest/MockSuggestedRouteTestRepo.dart';
import 'MockFireBaseAuth.dart';

// import 'BlocTesting/BalaghatocBloc_test/MockBalaghatocRepo.dart';

class MockChangeLocale extends Mock {
  void call(Locale locale);
}

Future<void> main() async {
  testGoldens('HomePage renders correctly', (tester) async {
    final widget = MaterialApp(
      home: Login(),
    );

    await tester.pumpWidgetBuilder(
      widget,
      surfaceSize: const Size(
          500, 1000), // The size can be adjusted as per the requirements
    );
    await tester.pumpAndSettle();

    await screenMatchesGolden(tester, 'login_page');
  });

  testGoldens('Golden test for CustomRoute page', (tester) async {
    await tester.pumpWidgetBuilder(
      MaterialApp(
        home: CustomRouteUI(
          CRRepository: MockCustomRoutes(),
        ),
      ),
      surfaceSize: const Size(500, 1000),
    );

    await tester.pumpAndSettle();

    await screenMatchesGolden(tester, 'CustomROute Page');
  });

  testGoldens('AllRoutes Test', (tester) async {
    await tester.pumpWidgetBuilder(
      MaterialApp(home: AllRouteUI(repo: MockAllRoutes())),
      surfaceSize: const Size(500, 1000),
    );
    await tester.pumpAndSettle();
    await screenMatchesGolden(tester, 'AllRoutes_page');
  });

  testGoldens('HomeScreen/Dashboard Test', (tester) async {
    await tester.pumpWidgetBuilder(
      MaterialApp(
          home: HomeScreen(
        auth: MockFirebaseAuth(),
      )),
      surfaceSize: const Size(500, 1000),
    );

    await tester.pumpAndSettle();

    await screenMatchesGolden(tester, 'HomeScreen_page');
  });

  testGoldens('Golden test for CustomRoute coordinates page', (tester) async {
    await tester.pumpWidgetBuilder(
      MaterialApp(
        home: CustomRouteUI(
          CRRepository: MockCustomRoutes(),
        ),
      ),
      surfaceSize: const Size(500, 1000),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(ValueKey(0)));
    await tester.pumpAndSettle();
    await screenMatchesGolden(tester, 'CustomRute_coordinatePage');
  });

  testGoldens('AllRoutes Coordinates Test', (tester) async {
    await tester.pumpWidgetBuilder(
      MaterialApp(home: AllRouteUI(repo: MockAllRoutes())),
      surfaceSize: const Size(500, 1000),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(ValueKey(0)));
    await tester.pumpAndSettle();
    await screenMatchesGolden(tester, 'AllRoutes_coordinate_page');
  });

  testGoldens('SuggestedRoute Test', (tester) async {
    await tester.pumpWidgetBuilder(
      MaterialApp(
          home: SuggestedRouteUI(suggestedRoutesRepo: MockSuggestedRoutes())),
      surfaceSize: const Size(500, 1000),
    );
    await tester.pumpAndSettle();
    await screenMatchesGolden(tester, 'suggestedRoute_page');
  });

  testGoldens('SuggestedRoute after okay Test', (tester) async {
    await tester.pumpWidgetBuilder(
      MaterialApp(
          home: SuggestedRouteUI(suggestedRoutesRepo: MockSuggestedRoutes())),
      surfaceSize: const Size(500, 1000),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(ValueKey("okay")));
    await tester.pumpAndSettle();
    await screenMatchesGolden(tester, 'suggestedRouteList_page');
  });

  // testGoldens('SuggestedRoute after okay with coordinates Test',
  //     (tester) async {
  //   await tester.pumpWidgetBuilder(
  //     MaterialApp(
  //         home: SuggestedRouteUI(suggestedRoutesRepo: MockSuggestedRoutes())),
  //     surfaceSize: const Size(500, 1000),
  //   );
  //   await tester.pumpAndSettle();
  //   await tester.tap(find.byKey(ValueKey("okay")));

  //   await tester.pumpAndSettle(Duration(seconds: 2))s;
  //   print("okay");
  //   await tester.pumpAndSettle();

  //   expect(find.byKey(ValueKey(0)), findsOneWidget);
  //   await tester.tap(find.byKey(ValueKey(0)));
  //   // print("null");
  //   // await tester.tap(find.byKey(ValueKey(0)));
  //   // await tester.tap(find.byKey(ValueKey("My Route")));
  //   await tester.pumpAndSettle();
  //   // await tester.pumpAndSettle(Duration(seconds: 2));
  //   await screenMatchesGolden(tester, 'suggestedRouteListCoordinate_page');
  // });

  testGoldens('Golden test for Add Route Form', (tester) async {
    await tester.pumpWidgetBuilder(
      MaterialApp(
        home: AddRouteForm(),
      ),
      surfaceSize: const Size(500, 1000),
    );
    await tester.pumpAndSettle();
    await screenMatchesGolden(tester, 'Add_RouteForm');
  });
}
