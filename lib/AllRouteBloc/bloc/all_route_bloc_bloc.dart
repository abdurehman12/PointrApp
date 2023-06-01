import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/AllRouteBloc/models/AllRoutes.dart';

import '../Repo/AllRoutes_Repo.dart';

part 'all_route_bloc_event.dart';
part 'all_route_bloc_state.dart';

class AllRouteBloc extends Bloc<AllRouteBlocEvent, AllRouteBlocState> {
  final AllRoutesRepo _PRepo;

  AllRouteBloc(this._PRepo) : super(AllRouteLoad()) {
    on<AllRouteBlocEvent>((event, emit) async {
      emit(AllRouteLoad());
      try {
        if (event is RouteAddEvent) {
          await _PRepo.createRoute(event.Name, event.coordinates);
          List<AllRoutes> data = [];
          emit(AllRouteSuccess(data));
        }

        if (event is RouteDeleteEvent) {
          await _PRepo.deleteRoute(event.id);
          List<AllRoutes> data = [];
          emit(AllRouteSuccess(data));
        }

        // if (event is readRouteEvent) {
        //   final AllRoutes data = await _PRepo.ReadProduct(event.id);
        //   List<ProductModels> data1 = [data];
        //   emit(ProductSuccess(data1));
        // }

        if (event is readAllRouteEvent) {
          final List<AllRoutes> data = await _PRepo.ReadAllRoutes();
          emit(AllRouteSuccess(data));
        }

        if (event is RouteUpdateEvent) {
          await _PRepo.updateRoute(event.Name, event.coordinates);
          List<AllRoutes> data = [];
          emit(AllRouteSuccess(data));
        }
      } catch (e) {
        print(e);
        emit(AllRouteError(e.toString()));
      }
    });
  }
}
