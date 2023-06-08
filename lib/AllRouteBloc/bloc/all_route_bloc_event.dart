part of 'all_route_bloc_bloc.dart';

abstract class AllRouteBlocEvent extends Equatable {
  const AllRouteBlocEvent();

  @override
  List<Object?> get props => [];
}

class RouteAddEvent extends AllRouteBlocEvent {
  final String Name;
  final List<LatLng> coordinates;

  const RouteAddEvent({
    required this.Name,
    required this.coordinates,
  });

  @override
  List<Object?> get props => [];
}

class RouteDeleteEvent extends AllRouteBlocEvent {
  final String id;

  const RouteDeleteEvent({required this.id});

  @override
  List<Object?> get props => [];
}

// class readRouteEvent extends AllRouteBlocEvent {
//   final String id;

//   const readRouteEvent({required this.id});

//   @override
//   List<Object?> get props => [];
// }

class readAllRouteEvent extends AllRouteBlocEvent {
  const readAllRouteEvent();

  @override
  List<Object?> get props => [];
}

class RouteUpdateEvent extends AllRouteBlocEvent {
  final String Name;
  final List<LatLng> coordinates;

  const RouteUpdateEvent({
    required this.Name,
    required this.coordinates,
  });
  @override
  List<Object?> get props => [];
}
