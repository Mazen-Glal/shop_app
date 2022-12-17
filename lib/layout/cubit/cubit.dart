import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/category_model/categories_model.dart';
import 'package:shop_app/models/change_favorites_model/change_favorites_model.dart';
import 'package:shop_app/models/get_favorites_model/get_favorites_model.dart';
import 'package:shop_app/models/home_model/home_model.dart';
import 'package:shop_app/models/login_model/login_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/setting_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/diohelper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens = [
    const ProductScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    SettingScreen()
  ];

  void changeBottomTap(int index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  HomeModel? model;
  Map<int, bool> favorites = {};
  void getHomeData(dynamic token) {
    emit(HomeDataLoadingState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      model = HomeModel.fromJson(value.data);
      for (var element in model!.data.products) {
        favorites.addAll({element.id: element.inFavorites});
      }
      emit(HomeDataSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(HomeDataErrorState());
    });
  }

  CategoryModel? categoryModel;
  void getCategoryData(dynamic token) {
    DioHelper.getData(
      url: CATEGORIES,
      token: token,
    ).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);

      emit(CategoryDataSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(CategoryDataErrorState());
    });
  }

  ChangeFavoritesModel? favoritesModel;
  void changeFavoritesState(int productID) {
    favorites[productID] = !favorites[productID]!;
    emit(ChangeFavoritesSuccessState());
    DioHelper.postData(
            url: FAVORITES, data: {'product_id': productID}, token: token)
        .then((value) {
      favoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (favoritesModel!.status != true) {
        favorites[productID] = !favorites[productID]!;
        showToast(message: favoritesModel!.message, state: ToastStates.ERROR);
      } else {
        // this will take a time to show
        getFavoritesData(token);
      }
      emit(ChangeFavoritesSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      favorites[productID] = !favorites[productID]!;
      emit(ChangeFavoritesErrorState());
    });
  }

  FavoritesModel? favoritesDataModel;
  void getFavoritesData(dynamic token) {
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesDataModel = FavoritesModel.fromJson(value.data);
      emit(GetFavoritesSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetFavoritesErrorState());
    });
  }

  LoginModel? profileModel;
  void getProfile(dynamic token) {
    emit(ProfileLoadingState());
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      profileModel = LoginModel.fromJson(value.data);
      emit(ProfileSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(ProfileErrorState());
    });
  }


  void getUpdate({
    required String? token,
    required String name,
    required String email,
    required String phone,
  }){
    emit(UpdateUserLoadingState());
    DioHelper.putData(
        url: UPDATE,
        token: token,
        data: {
          'name':name,
          'email':email,
          'phone':phone
        }
    ).then((value) {
      profileModel = LoginModel.fromJson(value.data);
      emit(UpdateUserSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(UpdateUserErrorState());
    });
  }
}
