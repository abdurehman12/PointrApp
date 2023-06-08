import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pointr/AllRouteBloc/bloc/all_route_bloc_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

import 'MockAllRoutesTestRepo.dart';

void main() {
  group("AllRouteBloc Test", () {
    late MockAllRoutes mockAllRouteTextRepo;
    late AllRouteBloc allRouteBloc;

    setUp(() {
      EquatableConfig.stringify = true;
      mockAllRouteTextRepo = MockAllRoutes();
      allRouteBloc = AllRouteBloc(mockAllRouteTextRepo);
    });

    blocTest<AllRouteBloc, AllRouteBlocState>(
      "test for Read success",
      build: () => allRouteBloc,
      act: (bloc) => bloc.add(readAllRouteEvent()),
      wait: const Duration(seconds: 2),
      expect: () => [isA<AllRouteLoad>(), isA<AllRouteSuccess>()],
    );

    blocTest<AllRouteBloc, AllRouteBlocState>(
      "test for update event",
      build: () => allRouteBloc,
      act: (bloc) => bloc.add(RouteUpdateEvent(
        Name: "My Route",
        coordinates: [],
      )),
      wait: const Duration(seconds: 2),
      expect: () => [isA<AllRouteLoad>(), isA<AllRouteSuccess>()],
    );

    blocTest<AllRouteBloc, AllRouteBlocState>(
      "test for Add event",
      build: () => allRouteBloc,
      act: (bloc) => bloc.add(RouteAddEvent(
        Name: "My Route",
        coordinates: [],
      )),
      wait: const Duration(seconds: 2),
      expect: () => [isA<AllRouteLoad>(), isA<AllRouteSuccess>()],
    );

    blocTest<AllRouteBloc, AllRouteBlocState>(
      "test for delet event",
      build: () => allRouteBloc,
      act: (bloc) => bloc.add(RouteDeleteEvent(
        // : "My Route";
        id: "My Route",
      )),
      wait: const Duration(seconds: 2),
      expect: () => [isA<AllRouteLoad>(), isA<AllRouteSuccess>()],
    );

    blocTest<AllRouteBloc, AllRouteBlocState>(
      "test for error event",
      build: () => allRouteBloc,
      act: (bloc) => bloc.add(RouteAddEvent(
        // : "My Route";
        Name: "1",
        coordinates: [],
      )),
      wait: const Duration(seconds: 2),
      expect: () => [isA<AllRouteLoad>(), isA<AllRouteError>()],
    );
  });
}
