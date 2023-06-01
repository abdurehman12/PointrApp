part of 'suggested_route_bloc_bloc.dart';

@immutable
class SuggestedRouteBlocState extends Equatable {
  const SuggestedRouteBlocState();

  @override
  List<Object?> get props => [];
}

class SuggestedRouteLoad extends SuggestedRouteBlocState {
  const SuggestedRouteLoad();

  @override
  List<Object?> get props => [];
}

class SuggestedRouteSuccess extends SuggestedRouteBlocState {
  final List<SuggestedRoutes> data;
  const SuggestedRouteSuccess(this.data);

  @override
  List<Object?> get props => [data];
}

class SuggestedRouteError extends SuggestedRouteBlocState {
  final String message;
  const SuggestedRouteError(this.message);

  @override
  List<Object?> get props => [message];
}

class SuggestedRouteMoved extends SuggestedRouteBlocState {
  const SuggestedRouteMoved();

  @override
  List<Object?> get props => [];
}

// class AllRouteBlocInitial extends AllRouteBlocState {}
