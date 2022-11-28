import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/state.dart';

import '../../models/categories/category_model.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopAppCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.categoryModel != null,
          builder: (context)=> ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                categoryBuilder(cubit.categoryModel!.data.data[index]),
            separatorBuilder: (context, index) => Container(
              color: Colors.grey,
              height: 1,
              margin: const EdgeInsets.only(left: 20),
            ),
            itemCount: cubit.categoryModel!.data.data.length,
          ),
          fallback: (context)=> const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget categoryBuilder(DataModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image.network(
              model.image,
              height: 100,
              width: 100,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              model.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios)),
          ],
        ),
      );
}
