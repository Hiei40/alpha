import 'package:alpharapp/core/constans/app_assets.dart' show AppAssets;
import 'package:alpharapp/core/constans/app_colors.dart';
import 'package:alpharapp/core/sharde/widget/default_button.dart' show DefaultButton;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constans/constants.dart';
import '../../core/network/local/cachehelper.dart';
import '../../core/network/remote/diohelper.dart';
import '../../main.dart';
import '../Auth/login/screen/widget/wave_background_painter.dart';


class ChooseBranchScreen extends StatelessWidget {
  const ChooseBranchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: CustomPaint(
            painter: WaveBackgroundPainter(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  30.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 60,
                    ),
                    child:


                    Image.asset(AppAssets.logo, width: screenWidth),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * .8,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //  Image.asset(AppAssets.logOutIcon),

                        SizedBox(height: 8.h),
                        Text(
                          'select_branch'.tr(),
                          style: TextStyle(
                            fontFamily: "Alexandria",
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.mainAppColor,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: DefaultButton(
                            text: "cairo_branch".tr(),
                            function: () async {
                              await CacheHelper.saveData(key: 'baseUrl', value: "http://51.91.6.70/TheOneApiElfarC");
                              await  CacheHelper.saveData(key: 'privateKey', value: "5554f61b8e7fbb9328bf78fc707cb42c");
                              await  CacheHelper.saveData(key: 'publicKey', value: "dd52cb03228834eb");
                              await CacheHelper.saveData(key: 'check', value: true );

                              await CacheHelper.saveData(key: 'sign', value: "ZGQ1MmNiMDMyMjg4MzRlYjpKUy9nZXpaVG9SWm1tYitVWXFnTkdkemo0dFZkcFplMnVUZndWejB4S3kwPQ==");
                              beasUrlCairoOrMa = CacheHelper.getData(key: 'baseUrl');
                              privateKey = CacheHelper.getData(key: 'privateKey');
                              publicKey = CacheHelper.getData(key: 'publicKey');

                              sign = CacheHelper.getData(key: 'sign');

                              // DioHelper.reset();
                              DioHelper.init();
                              // BlocProvider.of<AddOrderCubit>(context).getAllAddress();
                              // BlocProvider.of<HomeCubit>(context).getBannerOneImage();
                              // BlocProvider.of<HomeCubit>(context).getBannerTwoImage();
                              // BlocProvider.of<HomeCubit>(context) .getNewsMarquee();
                              // BlocProvider.of<HomeCubit>(context) .getBannerThreeImage();
                              // BlocProvider.of<HomeCubit>(context) .getBestSellers();
                              // BlocProvider.of<HomeCubit>(context).getNewProduct();
                              // BlocProvider.of<HomeCubit>(context) .getOfferProduct();
                              // BlocProvider.of<HomeCubit>(context) .getOfferTwoProduct();
                              // BlocProvider.of<HomeCubit>(context).getBiggestDiscountProducts();
                              //
                              // BlocProvider.of<CategoryCubit>(context).getMainCategory();
                              //
                              // BlocProvider.of<AddOrderCubit>(context).getAllAddress();
                              // BlocProvider.of<AddOrderCubit>(context).getCustomerSalesBasket();
                              // BlocProvider.of<AddOrderCubit>(context).getQuitity();
                              //BlocProvider(create: (context) => CartCubit());
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MyApp(locale: Locale(currentLang!),),
                                ),
                                    (route) => false,
                              );
                            },




                            borderRadius: 20,

                          ),
                        ),
                        SizedBox(height: 20.h),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: DefaultButton(
                            text: "mansoura_Branch".tr(),
                            borderRadius: 20,
                            function: () async {
                              await CacheHelper.saveData(key: 'baseUrl', value: "http://51.91.6.70/TheOneApiElfarM");
                              await CacheHelper.saveData(key: 'privateKey', value: "054b859550eb77560b3d4c6af8897e83");
                              await CacheHelper.saveData(key: 'publicKey', value: "b2810bb8c519327f");
                              await CacheHelper.saveData(key: 'check', value: false);

                              await  CacheHelper.saveData(key: 'sign', value: "YjI4MTBiYjhjNTE5MzI3ZjpRM0VBRTF2S09kVUVYZHc3cEVvQTZ2VW9ZMzF4UEQwRHZjbWFrQ2wwZkU4PQ==");
                              beasUrlCairoOrMa = "http://51.91.6.70/TheOneApiElfarM";
                              privateKey = CacheHelper.getData(key: 'privateKey');
                              publicKey = CacheHelper.getData(key: 'publicKey');
                              check  = CacheHelper.getData(key:  "check");
                              sign = CacheHelper.getData(key: 'sign');
                              print(beasUrlCairoOrMa);
                              //  DioHelper.reset();
                              DioHelper.init();
                              // BlocProvider.of<HomeCubit>(context).getBannerOneImage();

                              //   BlocProvider.of<HomeCubit>(context).getBannerTwoImage();
                              //   BlocProvider.of<HomeCubit>(context) .getNewsMarquee();
                              //   BlocProvider.of<HomeCubit>(context) .getBannerThreeImage();
                              //   BlocProvider.of<HomeCubit>(context) .getBestSellers();
                              //   BlocProvider.of<HomeCubit>(context).getNewProduct();
                              //   BlocProvider.of<HomeCubit>(context) .getOfferProduct();
                              //   BlocProvider.of<HomeCubit>(context) .getOfferTwoProduct();
                              //   BlocProvider.of<HomeCubit>(context).getBiggestDiscountProducts();
                              //
                              //   BlocProvider.of<CategoryCubit>(context).getMainCategory();
                              //
                              // BlocProvider.of<AddOrderCubit>(context).getAllAddress();
                              //   BlocProvider.of<AddOrderCubit>(context).getCustomerSalesBasket();
                              //   BlocProvider.of<AddOrderCubit>(context).getQuitity();
                              //
                              //   //BlocProvider(create: (context) => CartCubit());
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyApp(locale:  Locale(currentLang!)),
                                ),
                                    (route) => false,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
