import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  final int productId;
  final String image;
  final String description;
  final String name;
  final dynamic price;
  final List<String> images;

  const ProductDetailsScreen(
      {super.key,
      required this.productId,
      required this.image,
      required this.description,
      required this.name,
      required this.price,
      required this.images});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: GestureDetector(
        onHorizontalDragUpdate: (detaile) {
          if (detaile.delta.dx < 10) {
            Navigator.pop(context);
          }
        },
        child: Center(
          child: Align(
            alignment: Alignment.topRight,
            child: Hero(
              tag: productId,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(children: [
                        AspectRatio(
                            aspectRatio: 200 / 129,
                            child: CarouselSlider(
                                items: images
                                    .map((e) => Image(image: NetworkImage(e)))
                                    .toList(),
                                options: CarouselOptions(
                                    height: 200,
                                    aspectRatio: 16 / 9,
                                    viewportFraction: 1.0,
                                    initialPage: 0,
                                    enableInfiniteScroll: true,
                                    reverse: true,
                                    autoPlay: true,
                                    autoPlayInterval:
                                        const Duration(seconds: 6),
                                    autoPlayAnimationDuration:
                                        const Duration(milliseconds: 800),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    scrollDirection: Axis.horizontal))),

                      ]),
                      const SizedBox(
                        height: 30,
                      ),
                      detilseBody()
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget detilseBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                  overflow: TextOverflow.visible,
                  maxLines: 3,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            description,
            overflow: TextOverflow.ellipsis,
            maxLines: 10,
            style: TextStyle(
                color: Colors.grey.shade900,
                fontWeight: FontWeight.w300,
                fontSize: 17),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Center(
                child: MaterialButton(
                  color: Colors.deepPurple,
                  elevation: 50,
                  onPressed: () {},
                  child: const Text(
                    'Cart',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const Spacer(),
              Text(
                price.toString(),
                style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              )
            ],
          )
        ],
      ),
    );
  }
}
