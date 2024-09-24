import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Networking/Dio.dart';
import '../../Networking/SharedPrefrance.dart';
import '../CategoresScreen.dart';
import '../Favorite/FavoriteGetModel.dart';
import '../Favorite/FavoriteModel.dart';
import '../Favorite/FavoriteScreen.dart';
import '../Proudct/ProudctModel.dart';
import '../Proudct/product_screen.dart';
import 'shop_cuibt_state.dart';

class ShopCuibtCubit extends Cubit<ShopCuibtState> {
  ShopCuibtCubit() : super(ShopCuibtInitial());
  static ShopCuibtCubit get(context) => BlocProvider.of(context);
  static String? tokeen = ChachHelper.getData(key: 'token');

  int currentIndx = 0;
  List<Widget> screens = [
    const ProductScreen(),
    const favorite_screen(),
    const categores_screen()
  ];
  void ChangeNavBar(indx) {
    currentIndx = indx;
    emit(ChangeNavigBottom());
  }

  Map<int, bool> favorite = {};
  ProdectModel? prodectModel;
  Future<void> getProductData() async {
    emit(ShopDataLoading());
    try {
      final response =
          await networkdata.getData(url: 'home', token: tokeen, lan: 'en');
      prodectModel = ProdectModel.fromjson(response?.data);

      for (var element in prodectModel!.data!.products) {
        favorite.addAll({element.id: element.inFavorite});
      }

      final products =
          prodectModel!.data!.products; // Get the products list directly

      emit(
          ShopDataSuccessud(products)); // Emit the state with the products list
    } catch (onError) {
      print(onError.toString());
      // Consider emitting an error state here
    }
  }

  FavoriteGetModel? favoriteGetModel;
  FavoriteModel? favoriteModel;
  Future<void> setFavorite({required int prodecutID}) async {
    favorite[prodecutID] =
        !favorite[prodecutID]!; // Toggle favorite status locally
    emit(
        FavoriteButttonChange()); // Emit state to indicate change is in progress

    try {
      final response = await networkdata.postData(
          url: 'favorites', data: {'product_id': prodecutID}, token: tokeen);

      if (favoriteModel!.status) {
        // Successful API call
        emit(FavoriteButttonChangeSueccessfuly(
            productId: prodecutID, isFavorite: favorite[prodecutID]!));
        if (!favorite[prodecutID]!) {
          favoriteGetModel!.data.bigdata
              .removeWhere((element) => element.product.id == prodecutID);
          emit(Favorite_getData_successfuly());
        }
      } else {
        // API call failed, revert local change
        favorite[prodecutID] = !favorite[prodecutID]!;
        emit(FavoriteButttonChangeError());
      }
    } catch (e) {
      // Error during API call, revert local change
      favorite[prodecutID] = !favorite[prodecutID]!;
      emit(FavoriteButttonChangeError());
    }
  }

  Future<void> getFavoriteData() async {
    emit(Favorite_getData_loading()); // Emit loading state
    try {
      final response =
          await networkdata.getData(url: 'favorites', token: tokeen, lan: 'en');
      favoriteGetModel = FavoriteGetModel.fromJson(response!.data);
      emit(Favorite_getData_successfuly()); // Emit success state
    } catch (onError) {
      print(onError.toString());
      emit(Favorite_getData_Error(onError)); // Emit error state
    }
  }
}
