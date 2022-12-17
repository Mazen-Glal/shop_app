import 'package:shop_app/models/login_model/login_model.dart';

abstract class AppStates {}

class InitialState extends AppStates {}

class ChangeBottomNavState extends AppStates{}

class HomeDataLoadingState extends AppStates {}
class HomeDataSuccessState extends AppStates {}
class HomeDataErrorState extends AppStates {}

class CategoryDataSuccessState extends AppStates {}
class CategoryDataErrorState extends AppStates {}


class ChangeFavoritesSuccessState extends AppStates {}
class ChangeFavoritesErrorState extends AppStates {}

class GetFavoritesSuccessState extends AppStates {}
class GetFavoritesErrorState extends AppStates {}


class ProfileLoadingState extends AppStates{}
class ProfileSuccessState extends AppStates{}
class ProfileErrorState extends AppStates {}

class UpdateUserLoadingState extends AppStates{}
class UpdateUserSuccessState extends AppStates{}
class UpdateUserErrorState extends AppStates {}