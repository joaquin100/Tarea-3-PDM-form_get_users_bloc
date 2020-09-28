part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class LoadingState extends HomeState {}

class ErrorState extends HomeState {
  final String error;
  ErrorState({@required this.error});

  @override
  List<Object> get props => [];
}

class ShowUserState extends HomeState {
  final List<User> userList;
  ShowUserState({@required this.userList});

  @override
  List<Object> get props => [];
}
