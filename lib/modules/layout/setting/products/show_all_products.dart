import 'package:e_commerce_flutter/controllers/layout_cubit/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes/app_routers.dart';
import '../../../../core/style/icon_broken.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/screen_config.dart';
import '../../../../models/product_model.dart';
import '../../../widgets/build_circular_widget.dart';
import '../../../widgets/empty_screen.dart';
import 'add_product_screen.dart';

class ShowAllProductsScreen extends StatelessWidget {
  const ShowAllProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit()..getAllProduct(),
      child: BlocConsumer<LayoutCubit, LayoutState>(
        listener: (context, state) {},
        builder: (context, state) {
          LayoutCubit cubit = LayoutCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Products',
                style: TextStyle(fontSize: 20),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddProductScreen(),
                      ),
                    );
                  },
                  icon: const Icon(IconBroken.Plus),
                ),
              ],
            ),
            body: state is LayoutGetProductLoadingState
                ? const BuildCircularWidget()
                : cubit.products.isEmpty
                    ? const EmptyScreen(
                        image: AppImage.emptyImage,
                        text: 'No Products',
                      )
                    : ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        itemCount: cubit.products.length,
                        itemBuilder: (context, index) {
                          return _buildItemList(context,
                              item: cubit.products[index]);
                        },
                        separatorBuilder: (context, index) => AppSize.sv_10,
                      ),
          );
        },
      ),
    );
  }

  Widget _buildItemList(BuildContext context, {required ProductModel item}) {
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight * 0.16,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.pushNamed(
              context,
              Routers.PRODUCT_DETAILS,
              arguments: item,
            ),
            child: Hero(
              tag: 'product_image_${item.id}',
              child: Container(
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
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  maxLines: 2,
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
                Row(
                  children: [
                    Text(
                      '\$ ${item.price}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    AppSize.sh_15,
                    Row(
                      children: [
                        const Icon(
                          IconBroken.Category,
                          size: 14,
                          color: Colors.blue,
                        ),
                        AppSize.sh_5,
                        Text(
                          '${item.category!.name}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          AppSize.sh_5,
          Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.grey[300],
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddProductScreen(
                                  edit: 'edit', productModel: item)));
                    },
                    icon: const Icon(
                      IconBroken.Edit,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              AppSize.sv_5,
              Expanded(
                child: Container(
                  color: Colors.grey[300],
                  child: IconButton(
                    onPressed: () {
                      BlocProvider.of<LayoutCubit>(context)
                          .deleteProduct(item.id);
                    },
                    icon: const Icon(
                      IconBroken.Delete,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
