import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories/category_model.dart';
import 'package:shop_app/models/favorite/favorire_model.dart';
import 'package:shop_app/models/login/login_model.dart';
import 'package:shop_app/models/seaech/search_model.dart';
import 'package:shop_app/modules/settings/settings_const.dart';
import 'package:shop_app/shared/cubit/state.dart';
import 'package:shop_app/shared/network/local/hive.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import '../../models/home/home_model.dart';
import '../../models/settings/settings_model.dart';
import '../constant.dart';
import '../network/end_point.dart';

class ShopAppCubit extends Cubit<ShopAppStates> {
  ShopAppCubit() : super(ShopAppInitialState());

  static ShopAppCubit get(context) => BlocProvider.of(context);

  //============================== Dio Logic ================================

  //========================== user login ==============================

  late UserLoginModel loginModel;

  void userLogin({
    required String email,
    required String pass,
  }) {
    emit(ShopAppLoadingStates());
    DioHelper.postData(
      url: EndPoint.LOGIN,
      data: {
        'email': email,
        'password': pass,
      },
    ).then((value) {
      loginModel = UserLoginModel.fromjson(value.data);
      print(value.data);
      token = loginModel.data?.token;
      emit(ShopAppSuccessStates(loginModel));
    }).catchError((error) {
      print('error is =======================>   ${error.toString()}');
      emit(ShopAppErrorStates(error.toString()));
    });
  }


  //======================= get user data ==========
  late UserLoginModel userModel;

  void getUserData() {
    emit(ShopAppGetProfileLoadingStates());
    DioHelper.getData(
      url: EndPoint.PROFILE,
      token: token,
    ).then((value) {
      userModel = UserLoginModel.fromjson(value.data);
      emit(ShopAppGetProfileSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(ShopAppGetProfileErrorStates());
    });
  }


  //========================== user register ==============================

  late UserLoginModel registerModel;

  void userRegister({
    required String name,
    required String email,
    required String pass,
    required String phone,
  }) {
    emit(RegisterLoadingStates());
    DioHelper.postData(
      url: EndPoint.REGISTER,
      data: {
        'name': name,
        'email': email,
        'password': pass,
        'phone': phone,
      },
    ).then((value) {
      loginModel = registerModel = UserLoginModel.fromjson(value.data);
      print(value.data);
      token = registerModel.data?.token;
      getUserData();
      // UserProfileData.nameController.text = registerModel.data?.name??'';
      // UserProfileData.emailController.text = registerModel.data?.email??'';
      // UserProfileData.phoneController.text = registerModel.data?.phone??'';
      emit(RegisterSuccessStates(registerModel));
    }).catchError((error) {
      print('error is =======================>   ${error.toString()}');
      emit(RegisterErrorStates(error.toString()));
    });
  }

  //========================== get home data ==============================

  HomeModel? homeModel;

  Map<int, bool> favorite = {};

  void getHomeData() {
    emit(ShopAppHomeLoadingStates());
    DioHelper.getData(
      url: EndPoint.HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromjson(value.data);
      homeModel!.data.products.forEach((element) {
        favorite.addAll({
          element.id: element.in_favorites,
        });
      });
      emit(ShopAppHomeSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(ShopAppHomeErrorStates());
    });
  }

// ================================= Get Category Data ==============================================

  CategoriesModel? categoryModel;

  void getCategoryData() {
    DioHelper.getData(
      url: EndPoint.CATEGORY,
    ).then((value) {
      categoryModel = CategoriesModel.fromjson(value.data);
      print('CATEGORIES DATA == > $categoryModel');
      emit(ShopAppCategorySuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(ShopAppCategoryErrorStates());
    });
  }

// ================================= Get and Delete Favorite Product ================================

  late FavoriteModelChange favoriteModel;

  void postFavorite(int productId) {
    favorite[productId] = !favorite[productId]!;
    emit(ShopAppFavoriteLoadingStates());
    DioHelper.postData(
        url: EndPoint.FAVORITE,
        data: {'product_id': productId},
        token: token)
        .then((value) {
      favoriteModel = FavoriteModelChange.fromjson(value.data);
      print(value.data);
      if (!value.data['status']) {
        favorite[productId] = !favorite[productId]!;
      }
      getFavoriteData();
      emit(ShopAppFavoriteSuccessStatesPost(favoriteModel));
    }).catchError((error) {
      print(error.toString());
      favorite[productId] = !favorite[productId]!;
      emit(ShopAppFavoriteErrorStatesPost());
    });
  }

  //=========

  GetFavoriteData? favoriteData;

  void getFavoriteData() {
    emit(ShopAppFavoriteLoadingStates());
    DioHelper.getData(
      url: EndPoint.FAVORITE,
      token: token,
    ).then((value) {
      favoriteData = GetFavoriteData.fromjson(value.data);
      print('favoriteScreen DATA == > $favoriteData');
      emit(ShopAppFavoriteSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(ShopAppFavoriteErrorStates());
    });
  }

  // ================================= Get AND Update Profile Data ==================================

  late Profile? profileData;

  // void getProfile() {
  //   emit(ShopAppGetProfileLoadingStates());
  //   DioHelper.getData(
  //     url: EndPoint.PROFILE,
  //     token: token,
  //   ).then((value) {
  //     profileData = Profile.fromjson(value.data);
  //     // UserProfileData.nameController.text = profileData!.data.name;
  //     // UserProfileData.emailController.text = profileData!.data.email;
  //     // UserProfileData.phoneController.text = profileData!.data.phone;
  //     emit(ShopAppGetProfileSuccessStates(profileData!));
  //   }).catchError((error) {
  //     print('get profile error => ${error.toString()}');
  //     emit(ShopAppGetGetProfileErrorStates());
  //   });
  // }

  void updateProfile({
    required String name,
    required String email,
    required String phone,
  }) {
    DioHelper.putData(
      url: EndPoint.UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone
      },
    ).then((value) {
      profileData = Profile.fromjson(value.data);
      // UserProfileData.nameController.text = profileData!.data.name;
      // UserProfileData.emailController.text = profileData!.data.email;
      // UserProfileData.phoneController.text = profileData!.data.phone;
      emit(ShopAppUpdateProfileSuccessStates(profileData!.message!));
    }).catchError((error) {
      print('get profile error => ${error.toString()}');
      emit(ShopAppUpdateProfileErrorStates());
    });
  }

// ================================= SEARCH IN PRODUCT =====================================

  late SearchModel searchModel;
  void search({
    required String searchChar,
  }) {
    emit(SearchLoadingStates());
    DioHelper.postData(
      url: EndPoint.SEARCH,
      data: {
        "text" : searchChar,
      },
      token: token,
    ).then((value) {
      searchModel = SearchModel.fromjson(value.data);
      emit(SearchSuccessStates());
    }).catchError((error)
    {
      print('Search error => ${error.toString()}');
      emit(SearchErrorStates());
    });
  }


}
