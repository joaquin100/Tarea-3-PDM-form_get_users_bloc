part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetAllUsersEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class FilterUsersEvent extends HomeEvent {
  final bool filterEven; //even -> número par
  FilterUsersEvent({@required this.filterEven});

  @override
  List<Object> get props => [filterEven];
}
