import 'package:e_commerce_flutter/controllers/layout_cubit/layout_cubit.dart';
import 'package:e_commerce_flutter/core/utils/app_size.dart';
import 'package:e_commerce_flutter/core/widget/circular_progress_component.dart';

import 'package:e_commerce_flutter/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/routes/app_routers.dart';
import '../../../core/utils/screen_config.dart';

class CategoriesComponent extends StatelessWidget {
  final List<ProductModel> productList;
  const CategoriesComponent({super.key, required this.productList});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SizedBox(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight * 0.35,
          child: state is! LayoutGetProductLoadingState
              ? ListView.separated(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.02,
                    vertical: SizeConfig.screenHeight * 0.02,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: productList.length,
                  itemBuilder: (context, index) {
                    return _buildItemList(
                        context: context, item: productList[index]);
                  },
                  separatorBuilder: (context, index) => AppSize.sh_15,
                )
              : const CircularProgressComponent(),
        );
      },
    );
  }

  Widget _buildItemList({
    required BuildContext context,
    required ProductModel item,
  }) {
    return Container(
      width: SizeConfig.screenWidth * 0.50,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(5, 6), // changes position of shadow
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite_border,
                  color: Colors.red,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => Navigator.of(context).pushNamed(
                    Routers.PRODUCT_DETAILS,
                    arguments: item,
                  ),
                  child: Hero(
                    tag: 'product_image_${item.id}',
                    child: Container(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.screenHeight * 0.17,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage("${item.imageUrl}"),
                          fit: BoxFit.contain,
                          filterQuality: FilterQuality.low,
                        ),
                      ),
                    ),
                  ),
                ),
                AppSize.sv_10,
                Text(
                  '${item.name}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AppSize.sv_5,
                Text(
                  '\$ ${item.price}',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
