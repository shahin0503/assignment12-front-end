import 'package:assignment12_front_end/data/models/user/user_model.dart';
import 'package:assignment12_front_end/data/repositories/user_repository.dart';
import 'package:assignment12_front_end/logic/cubits/users_cubit/users_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit() : super(UsersInitialState()) {
    _initialize();
  }

    final UserRepository _userRepository = UserRepository();


  void _initialize() async {
    emit(UsersLoadingState(state.users));

    try {

      List<UserModel> users =
          await _userRepository.fetchAllUsers();

      emit(UsersLoadedState(users));

    } catch (error) {
      
      emit(UsersErrorState(state.users, error.toString()));
    }
  }
}
