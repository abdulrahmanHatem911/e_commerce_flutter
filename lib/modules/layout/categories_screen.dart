import 'package:e_commerce_flutter/modules/layout/setting/add_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controllers/layout_cubit/layout_cubit.dart';
import '../../core/routes/app_routers.dart';
import '../../core/style/icon_broken.dart';
import '../../core/utils/app_size.dart';
import '../../core/utils/app_strings.dart';
import '../../core/utils/screen_config.dart';
import '../../core/widget/circular_progress_component.dart';
import '../../models/category_model.dart';
import '../widgets/empty_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);
        return Scaffold(
          body: state is LayoutGetCategoryLoadingState
              ? const Center(
                  child: CircularProgressComponent(),
                )
              : state is LayoutGetCategorySuccessState
                  ? ListView.separated(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.screenWidth * 0.02,
                        vertical: SizeConfig.screenHeight * 0.02,
                      ),
                      itemBuilder: (context, index) {
                        return _buildItemList(
                          context: context,
                          item: LayoutCubit.get(context).categories[index],
                        );
                      },
                      separatorBuilder: (context, index) => AppSize.sv_10,
                      itemCount: LayoutCubit.get(context).categories.length,
                    )
                  : cubit.categories.isEmpty
                      ? const EmptyScreen(
                          image: AppImage.emptyImage, text: 'No Categories')
                      : state is LayoutGetCategoryErrorState
                          ? EmptyScreen(
                              image: AppImage.errorImage, text: state.error)
                          : ListView.separated(
                              padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.screenWidth * 0.02,
                                vertical: SizeConfig.screenHeight * 0.02,
                              ),
                              itemBuilder: (context, index) {
                                return _buildItemList(
                                  context: context,
                                  item: LayoutCubit.get(context)
                                      .categories[index],
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  AppSize.sv_10,
                              itemCount:
                                  LayoutCubit.get(context).categories.length,
                            ),
        );
      },
    );
  }

  Widget _buildItemList(
      {required BuildContext context, required CategoryModel item}) {
    return InkWell(
      onTap: () =>
          Navigator.pushNamed(context, Routers.GRID_VIEW, arguments: item),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth * 0.05,
            vertical: SizeConfig.screenHeight * 0.02),
        height: SizeConfig.screenHeight * 0.20,
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(item.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.05,
                  vertical: SizeConfig.screenHeight * 0.01,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  item.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddCategoryScreen(
                            edit: "edit",
                            model: item,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      IconBroken.Edit,
                      color: Colors.blue,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    onPressed: () {
                      BlocProvider.of<LayoutCubit>(context)
                          .deleteCategory(item.id);
                    },
                    icon: const Icon(
                      IconBroken.Delete,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
