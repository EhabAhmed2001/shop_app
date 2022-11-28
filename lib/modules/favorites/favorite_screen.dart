import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/favorite/favorire_model.dart';
import 'package:shop_app/shared/constant.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/state.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (context, index) {
            return favoriteBuilder(favoriteScreenData[index], context);
          },
          separatorBuilder: (context, index) => Container(
            height: 1,
            color: Colors.grey[400],
            margin: const EdgeInsetsDirectional.only(
              start: 12,
              bottom: 6,
              top: 6,
            ),
          ),
          itemCount: favoriteScreenData.length,
        );
      },
    );
  }
}

Widget favoriteBuilder(GetProductFavoriteData favoriteData, BuildContext context)
{
  return Container(
    padding: const EdgeInsetsDirectional.all(12),
    height: 120,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image.network(
              favoriteData.products.productImage.toString(),
              height: 120,
              width: 120,
            ),
            if (favoriteData.products.productDiscount != 0)
              Container(
                padding: const EdgeInsetsDirectional.all(6.0),
                color: Colors.red,
                child: const Text(
                  'OFFER',
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                favoriteData.products.productName.toString(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    favoriteData.products.productPrice.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      color: defaultColorLightMode,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  if (favoriteData.products.productDiscount != 0)
                    Text(
                      favoriteData.products.productOldPrice.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      ShopAppCubit.get(context).postFavorite(favoriteData.products.productId);
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: ShopAppCubit.get(context).favorite[favoriteData.products.productId]! ? Colors.red : Colors.grey,
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
