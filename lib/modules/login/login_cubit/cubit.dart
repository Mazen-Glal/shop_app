import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model/login_model.dart';
import 'package:shop_app/modules/login/login_cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/diohelper.dart';
class LoginCubit extends Cubit<LoginStates>
{
  LoginCubit():super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  late LoginModel loginModel;
  void userLogin({
    required String email,
    required String password,
  })
  {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email':email,
        'password':password
      },
    ).then((value) {
        loginModel = LoginModel.fromJson(value.data);
        emit(LoginSuccessState(loginModel));
    }).catchError((error){
        debugPrint(error.toString());
        emit(LoginErrorState(error.toString()));
    });
  }


  bool isPassword=true;
  void changePasswordVisibility()
  {
    isPassword=!isPassword;
    emit(ChangePasswordVisibilityState());
  }

}

