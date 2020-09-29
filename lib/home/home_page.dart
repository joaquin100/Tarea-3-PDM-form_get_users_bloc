import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc _homeBloc;
  @override
  void dispose() {
    _homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Userlist"),
        actions: <Widget>[
          PopupMenuButton<String>(
            icon: Icon(Icons.menu),
            onSelected: (String value) {
              print("VALUE->" + value);
              // ignore: non_constant_identifier_names
              bool is_even = value == 'Pares' ? true : false;
              print("BOOL->" + is_even.toString());
              //BlocProvider.of<HomeBloc>(context).add(GetAllUsersEvent());
              //HomeBloc()..add(FilterUsersEvent(filterEven: is_even));
              _homeBloc.add(FilterUsersEvent(filterEven: is_even));
              print("DONE");
            },
            itemBuilder: (BuildContext context) {
              return {'Pares', 'Impares'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) {
          _homeBloc = HomeBloc()..add(GetAllUsersEvent());
          //return HomeBloc()..add(GetAllUsersEvent());
          return _homeBloc;
        },
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            //mostrar snackbar y dálogos por eso se recomeindan los listeners
            if (state is ErrorState) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("Error: ${state.error}"),
                  ),
                );
            }
          },
          // ignore: missing_return
          builder: (context, state) {
            if (state is ShowUserState) {
              return RefreshIndicator(
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(
                    color: Colors.black,
                    height: 15,
                  ),
                  itemCount: state.userList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(state.userList[index].name),
                      subtitle: Text(
                        'Company:${state.userList[index].company.name}\nUsername:${state.userList[index].username}\nStreet:${state.userList[index].address.street}\n Phone:${state.userList[index].phone} ',
                      ),
                    );
                  },
                ),
                onRefresh: () async {
                  _homeBloc.add(GetAllUsersEvent());
                },
              );
            } else if (state is LoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Center(
              child: MaterialButton(
                onPressed: () {
                  _homeBloc.add(GetAllUsersEvent());
                },
                child: Text("Cargar de nuevo"),
              ),
            );
          },
        ),
      ),
    );
  }
}
