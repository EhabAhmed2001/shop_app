import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/constant.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/state.dart';
import '../../models/seaech/search_model.dart';

class search_screen extends StatelessWidget {
  const search_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopAppCubit, ShopAppStates>(
      builder: (context, state) {
        var searchController = TextEditingController();
        var cu = ShopAppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.close,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: TextFormField(
              decoration: const InputDecoration(
                hintText: "SEARCH",
                border: InputBorder.none,
              ),
              onChanged: (searchChar) {
                searchController.text = searchChar;
                cu.search(searchChar: searchController.text);
              },
            ),
            actions: [
              IconButton(
                onPressed: ()
                {
                  print("List length id ===> ${searchData.length}");
                },
                icon: const Icon(Icons.search),
                color: Colors.grey,
              ),
            ],
          ),
          body: state is SearchLoadingStates ? const LinearProgressIndicator() : ListView.separated(
            itemBuilder: (context, index) => searchListBuild(
              searchData: searchData[index],
              context: context,
            ),
            separatorBuilder: (context, index) => Container(
              height: 1,
              color: Colors.grey[400],
              margin: const EdgeInsetsDirectional.only(
                start: 12,
                bottom: 6,
                top: 6,
              ),
            ),
            itemCount: searchData.length,
          ),
        );
      },
    );
  }

  Widget searchListBuild({
    required Data searchData,
    required BuildContext context,
  }) {
    var cu = ShopAppCubit.get(context);
    return Container(
        padding: const EdgeInsetsDirectional.all(12),
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              searchData.image,
              height: 100,
              width: 100,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    searchData.name,
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
                        searchData.price.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: defaultColorLightMode,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopAppCubit.get(context).postFavorite(searchData.id);
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: cu.favorite[searchData.id]! ? Colors.red : Colors.grey,

                          //favorite[favoriteData.products.productId]!

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
