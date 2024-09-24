import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Proudct/boolMap.dart';
import '../cuibt/shop_cuibt_cubit.dart';
import '../cuibt/shop_cuibt_state.dart';
import 'FavoriteGetModel.dart';

class favorite_screen extends StatefulWidget {
  const favorite_screen({super.key});

  @override
  State<favorite_screen> createState() => _favorite_screenState();
}

class _favorite_screenState extends State<favorite_screen> {
  void initState() {
    super.initState();
    ShopCuibtCubit.get(context).getFavoriteData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCuibtCubit, ShopCuibtState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        BoolMapNotifier boolMapNotifier = BoolMapNotifier({}, []);
        return SafeArea(child: BlocBuilder<ShopCuibtCubit, ShopCuibtState>(
          builder: (context, state) {
            final favoriteGetModel =
                ShopCuibtCubit.get(context).favoriteGetModel;
            return ConditionalBuilder(
              condition: favoriteGetModel != null,
              builder: (context) => ListView.separated(
                  itemBuilder: (context, index) {
                    return BuildListView(
                        context, favoriteGetModel!.data.bigdata[index].product);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: favoriteGetModel!.data.bigdata.length),
              fallback: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ));
      },
    );
  }

  Widget BuildListView(context, F_Product product) {
    var cuibt = ShopCuibtCubit.get(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 120,
        child: Row(
          children: [
            Stack(alignment: Alignment.topLeft, children: [
              AspectRatio(
                aspectRatio: 400 / 451,
                child: Image(
                  image: NetworkImage(
                    '${product.image}',
                  ),
                  width: double.infinity,
                  fit: BoxFit.fill,
                  height: 120,
                  alignment: FractionalOffset.topCenter,
                ),
              ),
              if (product.discount != 0)
                const Text(
                  'Discound',
                  style: TextStyle(backgroundColor: Colors.red),
                )
            ]),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${product.name}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(fontSize: 20),
                    textDirection: TextDirection.ltr,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        '${product.price}',
                        style: const TextStyle(color: Colors.blue),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      if (product.discount != 0)
                        Text(
                          '${product.oldPrice?.round()}',
                          style: TextStyle(
                              color: Colors.grey[700],
                              decoration: TextDecoration.lineThrough),
                        ),
                      const Spacer(),
                      BlocListener<ShopCuibtCubit, ShopCuibtState>(
                          listener: (context, state) {
                        if (state is FavoriteButttonChangeSueccessfuly &&
                            state.productId == product.id) {
                          cuibt.favorite[product.id] = state.isFavorite;
                        }
                      }, child: BlocBuilder<ShopCuibtCubit, ShopCuibtState>(
                              builder: (context, state) {
                        bool isFavorite = cuibt.favorite[product.id] ?? false;
                        return IconButton(
                            onPressed: () {
                              cuibt.setFavorite(prodecutID: product.id);
                            },
                            isSelected: isFavorite,
                            selectedIcon: const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                            icon: const Icon(
                              Icons.favorite,
                              color: Colors.black54,
                            ));
                      }))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
