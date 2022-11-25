import 'package:e_commerce_flutter/core/utils/app_strings.dart';

class Dummy {
  final String image;
  Dummy({required this.image});
  static List<Dummy> dummyImage = [
    //random image from unsplash
    Dummy(image: AppImage.testImage01),
    Dummy(image: AppImage.testImage02),
    Dummy(image: AppImage.testImage03),
    Dummy(image: AppImage.testImage04),
    Dummy(image: AppImage.testImage05),
    Dummy(image: AppImage.testImage06),
  ];
  static List<Dummy> dummyBanner = [
    //random image from unsplash
    Dummy(image: AppImage.beaneryImage1),
    Dummy(image: AppImage.beaneryImage2),
    Dummy(image: AppImage.beaneryImage3),
    Dummy(image: AppImage.beaneryImage4),
    Dummy(image: AppImage.beaneryImage5),
    Dummy(image: AppImage.beaneryImage6),
  ];
}
