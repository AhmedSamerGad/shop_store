import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cuibt/shop_cuibt_cubit.dart';
import '../cuibt/shop_cuibt_state.dart';
import 'product_details_screen.dart';
import 'ProudctModel.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
    ShopCuibtCubit.get(context).getProductData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCuibtCubit, ShopCuibtState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCuibtCubit.get(context)..getProductData();
        return Scaffold(
          body: ConditionalBuilder(
              condition: cubit.prodectModel != null,
              builder: (context) => buildWidget(cubit.prodectModel!),
              fallback: (context) => const Center(
                    child: CircularProgressIndicator(),
                  )),
        );
      },
    );
  }

  Widget buildWidget(ProdectModel model) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 5, 0, 10),
      padding: const EdgeInsets.all(3),
      color: Colors.grey[300],
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(12)),
              child: CarouselSlider(
                items: model.data!.banners
                    .map((e) => Image(
                          image: NetworkImage('${e.image}'),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ))
                    .toList(),
                options: CarouselOptions(
                    height: 200,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1.0,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              child: GridView.count(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                childAspectRatio: 1 / 1.82,
                mainAxisSpacing: 30,
                crossAxisSpacing: 20,
                crossAxisCount: 2,
                children: List.generate(
                    model.data!.products.length,
                    (index) => Container(
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20)),
                        child:
                            buildGrid(model.data!.products[index], context))),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildGrid(Product model, context) {
    var cubit = ShopCuibtCubit.get(context);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                ProductDetailsScreen(
              productId: model.id,
              image: model.image!,
              description: model.description!,
              name: model.name!,
              price: model.price,
              images: model.images,
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0), // Start from theright
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Stack(alignment: Alignment.topLeft, children: [
              AspectRatio(
                aspectRatio: 350 / 451,
                child: Hero(
                  tag: model.id,
                  child: Image(
                    image: NetworkImage(
                      '${model.image}',
                    ),
                    width: double.infinity,
                    fit: BoxFit.fill,
                    height: 200,
                    alignment: FractionalOffset.topCenter,
                  ),
                ),
              ),
              if (model.discound != 0)
                const Text(
                  'Discount',
                  style: TextStyle(backgroundColor: Colors.red),
                )
            ]),
            Row(
              children: [
                Text(
                  '${model.price}',
                  style: const TextStyle(color: Colors.blue),
                ),
                const SizedBox(
                  width: 10,
                ),
                if (model.discound != 0)
                  Text(
                    '${model.oldPrice?.round()}',
                    style: TextStyle(
                        color: Colors.grey[700],
                        decoration: TextDecoration.lineThrough),
                  ),
                const Spacer(),
                BlocListener<ShopCuibtCubit, ShopCuibtState>(
                  listener: (context, state) {
                    if (state is FavoriteButttonChangeSueccessfuly &&
                        state.productId == model.id) {
                      cubit.favorite[model.id] = state.isFavorite;
                    }
                  },
                  child: BlocBuilder<ShopCuibtCubit, ShopCuibtState>(
                    builder: (context, state) {
                      bool isFavorite = cubit.favorite[model.id] ?? false;
                      return IconButton(
                        onPressed: () {
                          cubit.setFavorite(prodecutID: model.id);
                        },
                        isSelected: isFavorite,
                        selectedIcon: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.black54,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              '${model.name}',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(fontSize: 20),
              textDirection: TextDirection.ltr,
            )
          ],
        ),
      ),
    );
  }
}
