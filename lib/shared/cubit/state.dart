import 'package:shop_app/models/login/login_model.dart';
import 'package:shop_app/models/settings/settings_model.dart';

import '../../models/favorite/favorire_model.dart';

abstract class ShopAppStates{}

class ShopAppInitialState extends ShopAppStates{}

// Login Screen
class ShopAppLoadingStates extends ShopAppStates{}

class ShopAppSuccessStates extends ShopAppStates
{
  final UserLoginModel mode;
  ShopAppSuccessStates(this.mode);
}

class ShopAppErrorStates extends ShopAppStates
{
  final String error;
  ShopAppErrorStates(this.error);
}


// Home Screen
class ShopAppHomeLoadingStates extends ShopAppStates{}

class ShopAppHomeSuccessStates extends ShopAppStates {}

class ShopAppHomeErrorStates extends ShopAppStates {}

class ShopAppCategorySuccessStates extends ShopAppStates {}

class ShopAppCategoryErrorStates extends ShopAppStates {}

// Favorite Screen
class ShopAppFavoriteLoadingStates extends ShopAppStates{}

class ShopAppFavoriteSuccessStatesPost extends ShopAppStates {
  final FavoriteModelChange model;

  ShopAppFavoriteSuccessStatesPost(this.model);
}

class ShopAppFavoriteSuccessStates extends ShopAppStates{}

class ShopAppFavoriteErrorStatesPost extends ShopAppStates {}

class ShopAppFavoriteErrorStates extends ShopAppStates {}

class ShopAppGetFavoriteSuccessStates extends ShopAppStates {}

// get profile

class ShopAppGetProfileLoadingStates extends ShopAppStates {}

class ShopAppGetProfileSuccessStates extends ShopAppStates {}

class ShopAppGetProfileErrorStates extends ShopAppStates {}

// update profile

class ShopAppUpdateProfileSuccessStates extends ShopAppStates{
  final String msg;

  ShopAppUpdateProfileSuccessStates(this.msg);
}

class ShopAppUpdateProfileErrorStates extends ShopAppStates{}

//========= REGISTER

class RegisterLoadingStates extends ShopAppStates{}

class RegisterSuccessStates extends ShopAppStates
{
  final UserLoginModel mode;
  RegisterSuccessStates(this.mode);
}

class RegisterErrorStates extends ShopAppStates
{
  final String error;
  RegisterErrorStates(this.error);
}


class SearchSuccessStates extends ShopAppStates{}

class SearchErrorStates extends ShopAppStates{}

class SearchLoadingStates extends ShopAppStates{}
