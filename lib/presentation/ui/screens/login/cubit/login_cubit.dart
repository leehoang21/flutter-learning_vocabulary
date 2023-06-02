import 'package:equatable/equatable.dart';

import '../../../../bloc/base_bloc/base_bloc.dart';

part 'login_state.dart';

class LoginCubit extends BaseBloc<LoginState> {
  LoginCubit() : super(LoginInitial());
}
