import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pointr/SuggestedRouteBloc/bloc/suggested_route_bloc_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:pointr/SuggestedRouteBloc/models/SuggestedRoutes.dart';
import 'MockSuggestedRouteTestRepo.dart';

void main() {
  group("SuggestedRouteBloc Test", () {
    late MockSuggestedRoutes mockSuggestedRouteRepo;
    late SuggestedRouteBloc suggestedRouteBloc;

    setUp(() {
      EquatableConfig.stringify = true;
      mockSuggestedRouteRepo = MockSuggestedRoutes();
      suggestedRouteBloc = SuggestedRouteBloc(mockSuggestedRouteRepo);
    });

    blocTest<SuggestedRouteBloc, SuggestedRouteBlocState>(
      "test for Read success",
      build: () => suggestedRouteBloc,
      act: (bloc) => bloc.add(SuggestedAllRouteEvent()),
      wait: const Duration(seconds: 2),
      expect: () => [isA<SuggestedRouteLoad>(), isA<SuggestedRouteSuccess>()],
    );
    blocTest<SuggestedRouteBloc, SuggestedRouteBlocState>(
      "test for AddRoute event",
      build: () => suggestedRouteBloc,
      act: (bloc) => bloc.add(SuggestedRouteAddEvent(
        Name: "My Route",
        coordinates: [],
      )),
      wait: const Duration(seconds: 2),
      expect: () => [isA<SuggestedRouteLoad>(), isA<SuggestedRouteSuccess>()],
    );

    blocTest<SuggestedRouteBloc, SuggestedRouteBlocState>(
      "test for delete event",
      build: () => suggestedRouteBloc,
      act: (bloc) => bloc.add(
        SuggestedRouteDeleteEvent(index: 1),
      ),
      wait: const Duration(seconds: 2),
      expect: () => [isA<SuggestedRouteLoad>(), isA<SuggestedRouteMoved>()],
    );

    blocTest<SuggestedRouteBloc, SuggestedRouteBlocState>(
      "test for update route",
      build: () => suggestedRouteBloc,
      act: (bloc) => bloc.add(
        SuggestedRouteUpdateEvent(
          index: 1,
        ),
      ),
      wait: const Duration(seconds: 2),
      expect: () => [isA<SuggestedRouteLoad>(), isA<SuggestedRouteMoved>()],
    );

    blocTest<SuggestedRouteBloc, SuggestedRouteBlocState>(
      "test for error",
      build: () => suggestedRouteBloc,
      act: (bloc) => bloc.add(
        SuggestedRouteAddEvent(
          Name: "1",
          coordinates: [],
        ),
      ),
      wait: const Duration(seconds: 2),
      expect: () => [isA<SuggestedRouteLoad>(), isA<SuggestedRouteError>()],
    );
  });
}
