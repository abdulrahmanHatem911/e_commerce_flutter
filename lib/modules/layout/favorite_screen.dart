import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controllers/layout_cubit/layout_cubit.dart';
import '../../core/utils/app_size.dart';
import '../../core/utils/app_strings.dart';
import '../../core/utils/screen_config.dart';
import '../../models/product_model.dart';
import '../widgets/empty_screen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);
        if (cubit.databaseFavoritesProducts.isEmpty) {
          return const EmptyScreen(
            image: AppImage.emptyImage,
            text: "No Favorites Products",
          );
        } else {
          return Scaffold(
            body: ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 10.0,
              ),
              itemBuilder: (context, index) {
                return _buildItemList(
                  context: context,
                  item: cubit.databaseFavoritesProducts[index],
                );
              },
              separatorBuilder: (context, index) => AppSize.sv_10,
              itemCount: cubit.databaseFavoritesProducts.length,
            ),
          );
        }
      },
    );
  }

  Widget _buildItemList(
      {required BuildContext context, required ProductModel item}) {
    return Container(
      width: SizeConfig.screenWidth * 0.3,
      height: SizeConfig.screenWidth * 0.28,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: SizeConfig.screenWidth * 0.21,
            height: SizeConfig.screenWidth * 0.29,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              //color: Colors.amber,
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.contain,
                image: NetworkImage(item.imageUrl),
              ),
            ),
          ),
          AppSize.sh_10,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AppSize.sv_5,
                Text(
                  item.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
                AppSize.sv_5,
                Text(
                  '\$ ${item.price}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => LayoutCubit.get(context).insertToFavorites(item),
            icon: LayoutCubit.get(context).isFavoriteFromDatabase(item.id)
                ? const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )
                : const Icon(
                    Icons.favorite_border,
                    color: Colors.grey,
                  ),
          ),
        ],
      ),
    );
  }
}
