part of 'all_route_bloc_bloc.dart';

@immutable
class AllRouteBlocState extends Equatable {
  const AllRouteBlocState();

  @override
  List<Object?> get props => [];
}

class AllRouteLoad extends AllRouteBlocState {
  const AllRouteLoad();

  @override
  List<Object?> get props => [];
}

class AllRouteSuccess extends AllRouteBlocState {
  final List<AllRoutes> data;
  const AllRouteSuccess(this.data);

  @override
  List<Object?> get props => [data];
}

class AllRouteError extends AllRouteBlocState {
  final String message;
  const AllRouteError(this.message);

  @override
  List<Object?> get props => [message];
}

// class AllRouteBlocInitial extends AllRouteBlocState {}
