import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/layout_cubit/layout_cubit.dart';
import '../../../core/routes/app_routers.dart';
import '../../../core/utils/app_size.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/screen_config.dart';
import '../../../core/widget/circular_progress_component.dart';
import 'visa_screen.dart';

class ToggleScreen extends StatelessWidget {
  const ToggleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit(),
      child: Scaffold(
        appBar: AppBar(elevation: 0.0, title: const Text('Payment')),
        body: BlocConsumer<LayoutCubit, LayoutState>(
          listener: (context, state) {
            if (state is PaymentRefCodeSuccessStates) {
              CircularProgressComponent.showSnackBar(
                context: context,
                message: "Success get ref code ",
                color: Colors.green.shade400,
              );
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routers.REF_CODE_SCREEN,
                (route) => false,
              );
            }
            if (state is PaymentRefCodeErrorStates) {
              CircularProgressComponent.showSnackBar(
                context: context,
                message: "Error get ref code",
                color: Colors.red.shade400,
              );
            }
          },
          builder: (context, state) {
            var cubit = LayoutCubit.get(context);
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const VisaScreen(),
                          ),
                          (route) => false,
                        );
                      },
                      child: Container(
                        height: SizeConfig.screenHeight * .16,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey.shade500, width: 2.0),
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: SizeConfig.screenWidth * 0.2,
                              height: SizeConfig.screenHeight * 0.06,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(AppImage.paymentCard),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            AppSize.sh_5,
                            Expanded(
                              child: Text(
                                "Visa Card",
                                style: GoogleFonts.ubuntu(
                                  fontSize: 20.0,
                                  color: Colors.grey.shade900,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    AppSize.sv_20,
                    InkWell(
                      onTap: () => cubit.getRefCode(),
                      child: Container(
                        height: SizeConfig.screenHeight * .16,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey.shade500, width: 2.0),
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: SizeConfig.screenWidth * 0.2,
                              height: SizeConfig.screenHeight * 0.06,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(AppImage.paymentCash),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            AppSize.sh_5,
                            Expanded(
                              child: Text(
                                "Referral Code",
                                style: GoogleFonts.ubuntu(
                                  fontSize: 20.0,
                                  color: Colors.grey.shade900,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
