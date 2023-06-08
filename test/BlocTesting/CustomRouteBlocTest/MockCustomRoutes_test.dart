import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pointr/AllRouteBloc/bloc/all_route_bloc_bloc.dart';
import 'package:pointr/CustomRouteBloc/bloc/Custom_route_bloc_bloc.dart';
// import 'package:pointr/AllRouteBloc/bloc/all_route_bloc_bloc.dart';
// import 'package:pointr/CustomRouteBloc/bloc/custom_route_bloc_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:pointr/CustomRouteBloc/models/CustomRoutes.dart';
import 'package:pointr/classes/custom_route.dart';
// import '/CustomRouteBloc/bloc/custom_route_bloc_state.dart';

import 'MockCustomRouteTestRepo.dart';

void main() {
  group("AllRouteBloc Test", () {
    late MockCustomRoutes mockAllRouteTextRepo;
    late CustomRouteBloc customRoutesBloc;

    setUp(() {
      EquatableConfig.stringify = true;
      mockAllRouteTextRepo = MockCustomRoutes();
      customRoutesBloc = CustomRouteBloc(mockAllRouteTextRepo);
    });

    blocTest<CustomRouteBloc, CustomRouteBlocState>(
      "test for Read success",
      build: () => customRoutesBloc,
      act: (bloc) => bloc.add(CustomAllRouteEvent()),
      wait: const Duration(seconds: 2),
      expect: () => [isA<CustomRouteLoad>(), isA<CustomRouteSuccess>()],
    );

    blocTest<CustomRouteBloc, CustomRouteBlocState>(
      "test for broadcast event",
      build: () => customRoutesBloc,
      act: (bloc) => bloc.add(CustomRouteBroadCastEvent(
        obj: CustomRoutes(
          routeName: "My Route",
          routeStops: [],
        ),
      )),
      wait: const Duration(seconds: 2),
      expect: () => [isA<CustomRouteLoad>(), isA<CustomRouteMoved>()],
    );

    blocTest<CustomRouteBloc, CustomRouteBlocState>(
      "test for delete event",
      build: () => customRoutesBloc,
      act: (bloc) => bloc.add(CustomRouteDeleteEvent(
        obj: CustomRoutes(
          routeName: "My Route",
          routeStops: [],
        ),
      )),
      wait: const Duration(seconds: 2),
      expect: () => [isA<CustomRouteLoad>()],
    );

    blocTest<CustomRouteBloc, CustomRouteBlocState>(
      "test for add route",
      build: () => customRoutesBloc,
      act: (bloc) => bloc.add(
        CustomRouteAddEvent(
          Name: "My Route",
          coordinates: [],
        ),
      ),
      wait: const Duration(seconds: 2),
      expect: () => [isA<CustomRouteLoad>(), isA<CustomRouteSuccess>()],
    );

    blocTest<CustomRouteBloc, CustomRouteBlocState>(
      "test for error",
      build: () => customRoutesBloc,
      act: (bloc) => bloc.add(
        CustomRouteAddEvent(
          Name: "1",
          coordinates: [],
        ),
      ),
      wait: const Duration(seconds: 2),
      expect: () => [isA<CustomRouteLoad>(), isA<CustomRouteError>()],
    );
  });
}
