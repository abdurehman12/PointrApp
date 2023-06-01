import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../Repo/CustomRoutes_Repo.dart';
import '../models/CustomRoutes.dart';
part 'Custom_route_bloc_event.dart';
part 'Custom_route_bloc_state.dart';

class CustomRouteBloc extends Bloc<CustomRouteBlocEvent, CustomRouteBlocState> {
  final CustomRoutesRepo _PRepo;

  CustomRouteBloc(this._PRepo) : super(CustomRouteLoad()) {
    on<CustomRouteBlocEvent>((event, emit) async {
      emit(CustomRouteLoad());
      try {
        if (event is CustomRouteAddEvent) {
          await _PRepo.createRoute(event.Name, event.coordinates);
          List<CustomRoutes> data = [];
          emit(CustomRouteSuccess(data));
        }

        if (event is CustomRouteBroadCastEvent) {
          await _PRepo.addToSuggested(event.obj);
          // List<CustomRoutes> data = [];
          emit(CustomRouteMoved());
        }

        // if (event is readRouteEvent) {
        //   final AllRoutes data = await _PRepo.ReadProduct(event.id);
        //   List<ProductModels> data1 = [data];
        //   emit(ProductSuccess(data1));
        // }

        if (event is CustomAllRouteEvent) {
          final List<CustomRoutes> data = await _PRepo.ReadAllCustomRoutes();
          emit(CustomRouteSuccess(data));
        }

        // if (event is CustomRouteUpdateEvent) {
        //   await _PRepo.removeFromCustom(event.index);
        //   // List<CustomRoutes> data = [];
        //   emit(CustomRouteMoved());
        // }
      } catch (e) {
        print(e);
        emit(CustomRouteError(e.toString()));
      }
    });
  }
}
