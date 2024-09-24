import 'package:equatable/equatable.dart';

import '../Favorite/FavoriteModel.dart';
import '../Proudct/ProudctModel.dart';

abstract class ShopCuibtState extends Equatable {
  const ShopCuibtState();
  @override
  List<Object> get props => [];
}

class ShopCuibtInitial extends ShopCuibtState {}

class ChangeNavigBottom extends ShopCuibtState {}

class ShopDataSuccessud extends ShopCuibtState {
  final List<Product> products;

  const ShopDataSuccessud(this.products);

  @override
  List<Object> get props => [products];
}

class ShopDataLoading extends ShopCuibtState {}

class ShopDataError extends ShopCuibtState {
  final String error;

  const ShopDataError(this.error);
  @override
  List<Object> get props => [error];
}

class FavoriteButttonChangeSueccessfuly extends ShopCuibtState {
  final int productId;
  final bool isFavorite;
  const FavoriteButttonChangeSueccessfuly(
      {required this.productId, required this.isFavorite});

  @override
  List<Object> get props => [productId, isFavorite];
}

class FavoriteButttonChangeError extends ShopCuibtState {}

class FavoriteButttonChange extends ShopCuibtState {}

class Favorite_getData_loading extends ShopCuibtState {}

class Favorite_getData_successfuly extends ShopCuibtState {}

class Favorite_getData_Error extends ShopCuibtState {
  final error;
  Favorite_getData_Error(this.error);
}
