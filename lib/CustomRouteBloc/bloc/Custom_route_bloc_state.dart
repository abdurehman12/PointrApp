part of 'Custom_route_bloc_bloc.dart';

@immutable
class CustomRouteBlocState extends Equatable {
  const CustomRouteBlocState();

  @override
  List<Object?> get props => [];
}

class CustomRouteLoad extends CustomRouteBlocState {
  const CustomRouteLoad();

  @override
  List<Object?> get props => [];
}

class CustomRouteSuccess extends CustomRouteBlocState {
  final List<CustomRoutes> data;
  const CustomRouteSuccess(this.data);

  @override
  List<Object?> get props => [data];
}

class CustomRouteError extends CustomRouteBlocState {
  final String message;
  const CustomRouteError(this.message);

  @override
  List<Object?> get props => [message];
}

class CustomRouteMoved extends CustomRouteBlocState {
  const CustomRouteMoved();

  @override
  List<Object?> get props => [];
}

// class AllRouteBlocInitial extends AllRouteBlocState {}
