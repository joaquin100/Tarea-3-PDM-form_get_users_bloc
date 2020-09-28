import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:form_get_users_bloc/models/user.dart';
import 'package:http/http.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final _link = "https://jsonplaceholder.typicode.com/users";
  List<User> _userList = List();

  HomeBloc() : super(HomeInitial());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is GetAllUsersEvent) {
      yield LoadingState();
      await _getAllUsers();
      if (this._userList.isNotEmpty) {
        yield ShowUserState(userList: this._userList);
      } else {
        yield ErrorState(error: "No hay elementos por mostrar");
      }
    } else if (event is FilterUsersEvent) {
      print(event.props);

      print("Filter users");
      yield LoadingState();

      if (this._userList.isNotEmpty) {
        await _getAllFilterUsers(event.props[0]);
        yield ShowUserState(userList: this._userList);
      } else {
        yield ErrorState(error: "No hay elementos por mostrar");
      }
    }
  }

  Future _getAllUsers() async {
    try {
      print("EJECUTÁNDOSE _getAllUsers");
      Response response = await get(_link);
      if (response.statusCode == 200) {
        this._userList = List();
        List<dynamic> data = jsonDecode(response.body);
        this._userList = data
            .map(
              (element) => User.fromJson(element),
            )
            .toList();
      }
      print(this._userList.toString());
    } catch (error) {
      print(error.toString());
      this._userList = List();
    }
  }

  // ignore: non_constant_identifier_names
  Future _getAllFilterUsers(bool is_even_number) async {
    try {
      print("EJECUTÁNDOSE _getAllFilterUsers");
      Response response = await get(_link);
      if (response.statusCode == 200) {
        this._userList = List();
        List<dynamic> data = jsonDecode(response.body);

        this._userList = data
            .map(
              (element) => User.fromJson(element),
            )
            .toList();

        if (is_even_number) {
          this._userList =
              this._userList.where((element) => element.id % 2 == 0).toList();
        } else {
          this._userList =
              this._userList.where((element) => element.id % 2 != 0).toList();
        }
        print(this._userList.toString());
      }
    } catch (error) {
      print(error.toString());
      this._userList = List();
    }
  }
}
