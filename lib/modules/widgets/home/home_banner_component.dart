import 'package:e_commerce_flutter/core/style/app_color.dart';
import 'package:e_commerce_flutter/core/utils/app_size.dart';
import 'package:e_commerce_flutter/core/utils/screen_config.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../controllers/layout_cubit/layout_cubit.dart';
import '../../../core/utils/dummy_data.dart';

class HomeBannerComponent extends StatelessWidget {
  HomeBannerComponent({super.key});
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ).copyWith(bottom: 0),
      height: SizeConfig.screenHeight * 0.28,
      child: Stack(
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.26,
            child: PageView(
              controller: pageController,
              children: Dummy.dummyBanner
                  .map((e) => Stack(
                        fit: StackFit.expand,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              e.image,
                              fit: BoxFit.cover,
                              scale: 1,
                              filterQuality: FilterQuality.low,
                            ),
                          ),
                          Positioned(
                            left: 20,
                            bottom: 5,
                            child: Container(
                              width: SizeConfig.screenWidth * 0.4,
                              height: SizeConfig.screenHeight * 0.2,
                              decoration: BoxDecoration(
                                color: Colors.black12.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Text(
                                        'Get the special discount',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      AppSize.sv_5,
                                      Text(
                                        '%50\nOFF',
                                        style: TextStyle(
                                          color: AppColor.white,
                                          fontSize: 35,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                        ],
                      ))
                  .toList(),
            ),
          ),
          Positioned(
              right: SizeConfig.screenWidth * 0.3,
              bottom: 0,
              child: SmoothPageIndicator(
                controller: pageController,
                count: Dummy.dummyBanner.length,
                effect: ExpandingDotsEffect(
                  expansionFactor: 5,
                  dotWidth: 8,
                  dotHeight: 5,
                  spacing: 4,
                  activeDotColor: AppColor.primerColor,
                  dotColor: Colors.grey,
                ),
                onDotClicked: (index) {
                  pageController.animateToPage(index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut);
                },
              ))
        ],
      ),
    );
  }
}
