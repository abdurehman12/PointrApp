import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/SuggestedRouteBloc/models/SuggestedRoutes.dart';
import 'package:flutter/material.dart';

import '../Repo/SuggestedRoutes_Repo.dart';
part 'suggested_route_bloc_event.dart';
part 'suggested_route_bloc_state.dart';

class SuggestedRouteBloc
    extends Bloc<SuggestedRouteBlocEvent, SuggestedRouteBlocState> {
  final SuggestedRoutesRepo _PRepo;

  SuggestedRouteBloc(this._PRepo) : super(const SuggestedRouteLoad()) {
    on<SuggestedRouteBlocEvent>((event, emit) async {
      emit(const SuggestedRouteLoad());
      try {
        if (event is SuggestedRouteAddEvent) {
          await _PRepo.createRoute(event.Name, event.coordinates);
          List<SuggestedRoutes> data = [];
          emit(SuggestedRouteSuccess(data));
        }

        if (event is SuggestedRouteDeleteEvent) {
          await _PRepo.addToApproved(event.index);
          // List<SuggestedRoutes> data = [];
          emit(const SuggestedRouteMoved());
        }

        // if (event is readRouteEvent) {
        //   final AllRoutes data = await _PRepo.ReadProduct(event.id);
        //   List<ProductModels> data1 = [data];
        //   emit(ProductSuccess(data1));
        // }

        if (event is SuggestedAllRouteEvent) {
          final List<SuggestedRoutes> data = await _PRepo.ReadAllRoutes();
          emit(SuggestedRouteSuccess(data));
        }

        if (event is SuggestedRouteUpdateEvent) {
          await _PRepo.removeFromSuggested(event.index);
          // List<SuggestedRoutes> data = [];
          emit(const SuggestedRouteMoved());
        }
      } catch (e) {
        print(e);
        emit(SuggestedRouteError(e.toString()));
      }
    });
  }
}
