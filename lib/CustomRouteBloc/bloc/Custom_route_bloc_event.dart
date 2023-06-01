part of 'Custom_route_bloc_bloc.dart';

abstract class CustomRouteBlocEvent extends Equatable {
  const CustomRouteBlocEvent();

  @override
  List<Object?> get props => [];
}

class CustomRouteAddEvent extends CustomRouteBlocEvent {
  final String Name;
  final List<LatLng> coordinates;

  const CustomRouteAddEvent({
    required this.Name,
    required this.coordinates,
  });

  @override
  List<Object?> get props => [];
}

class CustomRouteDeleteEvent extends CustomRouteBlocEvent {
  final CustomRoutes obj;

  const CustomRouteDeleteEvent({required this.obj});

  @override
  List<Object?> get props => [];
}

class CustomRouteBroadCastEvent extends CustomRouteBlocEvent {
  final CustomRoutes obj;

  const CustomRouteBroadCastEvent({required this.obj});

  @override
  List<Object?> get props => [];
}

class CustomAllRouteEvent extends CustomRouteBlocEvent {
  const CustomAllRouteEvent();

  @override
  List<Object?> get props => [];
}

// class CustomRouteUpdateEvent extends CustomRouteBlocEvent {  
//   // final String Name;
//   // final List<LatLng> coordinates;
//   final int index;
//   const CustomRouteUpdateEvent({
//     required this.index,
//   });
//   @override
//   List<Object?> get props => [];
// }
