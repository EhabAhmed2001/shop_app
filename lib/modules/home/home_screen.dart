import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/home/home_model.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/state.dart';
import '../../shared/constant.dart';

class home_screen extends StatelessWidget {
  const home_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {
        if(state is ShopAppFavoriteSuccessStatesPost)
          {
            if(!state.model.status)
              {
                toast(text: state.model.message, state: toastColor.ERROR);
              }
            else
              {
                toast(text: state.model.message, state: toastColor.SUCCESS);
              }

          }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopAppCubit.get(context).homeModel != null,
          fallback: (context) =>
              const Center(child: CircularProgressIndicator(),),
          builder: (context) =>
              homeBuilder(ShopAppCubit.get(context).homeModel!,context),
        );
      },
    );
  }

  Widget homeBuilder(HomeModel model,context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          CarouselSlider(
            items: model.data.banner.map((element) =>
                Image(
                    image: NetworkImage('${element.image}'),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ).toList(),
            options: CarouselOptions(
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              viewportFraction: 1.0,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Container(
            color: Colors.grey[200],
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              childAspectRatio: 1/1.68,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              children: List.generate(
                model.data.products.length,
                (index) => itemBuild(model.data.products[index],context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemBuild(Products product ,BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                // Image.network(
                //   product.image,
                //   height: 200,
                //   width: double.infinity,
                // ),
                CarouselSlider(
                  items: product.images.map((element) =>
                      Image(
                        image: NetworkImage(element.toString()),
                        width: double.infinity,
                        height: 200,
                       //fit: BoxFit.cover,
                      ),
                  ).toList(),
                  options: CarouselOptions(
                    height: 200,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    viewportFraction: 1.0,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                if(product.discount!=0)
                  Container(
                  padding: const EdgeInsetsDirectional.all(6.0),
                  color: Colors.red,
                  child: const Text(
                    'OFFER',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.3,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${product.price.round()} LE',
                      style: const TextStyle(
                        fontSize: 14,
                        color: defaultColorLightMode,
                      ),
                    ),
                    const SizedBox(width: 10),

                    if(product.discount!=0)
                    Text(
                      '${product.old_price.round()} LE',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopAppCubit.get(context).postFavorite(product.id);
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: ShopAppCubit.get(context).favorite[product.id]! ? Colors.red : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
