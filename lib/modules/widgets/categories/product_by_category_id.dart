import 'package:e_commerce_flutter/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controllers/layout_cubit/layout_cubit.dart';
import '../../../core/utils/app_size.dart';
import '../../../core/widget/build_item_list.dart';

class ProductByCategoryId extends StatelessWidget {
  const ProductByCategoryId({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as CategoryModel;
    return BlocProvider(
      create: (context) => LayoutCubit()
        ..getProductByCategoryIdDio(
          categoryId: args.id,
        ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
        ),
        body: BlocConsumer<LayoutCubit, LayoutState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = LayoutCubit.get(context);
            if (state is LayoutGetProductByCategoryIdErrorState) {
              return Center(
                child: Text(
                  state.error,
                  style: Theme.of(context).textTheme.headline6,
                ),
              );
            } else if (state is LayoutGetProductByCategoryIdLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 10.0,
                ),
                itemBuilder: (context, index) {
                  return BuildItemListComponent(
                    item: cubit.productsByCategoryId[index],
                  );
                },
                separatorBuilder: (context, index) => AppSize.sv_10,
                itemCount: cubit.productsByCategoryId.length,
              );
            }
          },
        ),
      ),
    );
  }
}