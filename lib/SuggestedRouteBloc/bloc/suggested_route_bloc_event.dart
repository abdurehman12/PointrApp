part of 'suggested_route_bloc_bloc.dart';

abstract class SuggestedRouteBlocEvent extends Equatable {
  const SuggestedRouteBlocEvent();

  @override
  List<Object?> get props => [];
}

class SuggestedRouteAddEvent extends SuggestedRouteBlocEvent {
  final String Name;
  final List<LatLng> coordinates;

  const SuggestedRouteAddEvent({
    required this.Name,
    required this.coordinates,
  });

  @override
  List<Object?> get props => [];
}

class SuggestedRouteDeleteEvent extends SuggestedRouteBlocEvent {
  final int index;

  const SuggestedRouteDeleteEvent({required this.index});

  @override
  List<Object?> get props => [];
}

class SuggestedreadRouteEvent extends SuggestedRouteBlocEvent {
  final String id;

  const SuggestedreadRouteEvent({required this.id});

  @override
  List<Object?> get props => [];
}

class SuggestedAllRouteEvent extends SuggestedRouteBlocEvent {
  const SuggestedAllRouteEvent();

  @override
  List<Object?> get props => [];
}

class SuggestedRouteUpdateEvent extends SuggestedRouteBlocEvent {
  // final String Name;
  // final List<LatLng> coordinates;
  final int index;
  const SuggestedRouteUpdateEvent({
    required this.index,
  });
  @override
  List<Object?> get props => [];
}
