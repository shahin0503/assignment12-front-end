import 'package:assignment12_front_end/data/models/user/user_model.dart';

abstract class UsersState {
  final List<UserModel> users;
  UsersState(this.users);
}

class UsersInitialState extends UsersState {
  UsersInitialState() : super([]);
}

class UsersLoadingState extends UsersState {
  UsersLoadingState(super.users);
}

class UsersLoadedState extends UsersState {
  UsersLoadedState(super.users);
}

class UsersErrorState extends UsersState {
  final String message;
  UsersErrorState(super.users, this.message);
}
