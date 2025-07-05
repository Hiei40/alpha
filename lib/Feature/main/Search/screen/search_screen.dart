import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constans/app_assets.dart';
import '../../../../core/constans/app_colors.dart';
import '../../../../core/network/local/cachehelper.dart';

import '../../../../core/sharde/widget/navigation.dart';
import '../../product_details/screen/product_details_screen.dart';
import '../manager/search_cubit.dart';
import '../manager/search_state.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLang = CacheHelper.getData(key: 'changeLang') ?? 'ar';
    final currentLocale = context.locale;

    return Scaffold(
      backgroundColor: AppColors.backgroundAppColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundAppColor,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 0),
          child: TextField(
            onChanged: (String value) {
              final cubit = BlocProvider.of<SearchCubit>(context);
              cubit.debounce?.cancel();
              cubit.debounce = Timer(const Duration(milliseconds: 500), () {
                if (value.isEmpty) {
                  cubit.searchKey(searchKey: '');
                } else if (value.length >= 3) {
                  cubit.searchKey(searchKey: value);
                }
              });
            },
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: 'search'.tr(),
              hintStyle: GoogleFonts.alexandria(
                textStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff6A6A6A),
                ),
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SvgPicture.asset(
                  AppAssets.searchIcon,
                  width: 20,
                  height: 20,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
            style: GoogleFonts.alexandria(
              textStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xff6A6A6A),
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          if (state is SearchLoading) {
            return Center(
              child: Lottie.asset(
                AppAssets.loading,
                width: 200.0,
                height: 200.0,
                fit: BoxFit.fill,
              ),
            );
          }

          if (state is SearchSuccess) {
            final searchProduct = BlocProvider.of<SearchCubit>(context);

            return Column(
              children: [
                // لو حابب تضيف عنوان أو أي حاجة فوق الليست
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    child: ListView.separated(
                      itemCount: searchProduct.searchList.length,
                      itemBuilder: (context, index) {
                        final item = searchProduct.searchList[index];

                        return InkWell(
                          onTap: () {
                            navigato(
                              context,
                              ProductDetailsScreen(
                                productId: item.productId,
                                categoryId: item.categoryId,
                              ),
                            );
                          },
                          child: SizedBox(
                            height: 90.h,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: CachedNetworkImage(
                                        width: MediaQuery.sizeOf(context).width,
                                        imageUrl: item.productImage.toString(),
                                        placeholder:
                                            (context, url) => Padding(
                                              padding: const EdgeInsets.all(
                                                8.0,
                                              ),
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                                      value: 1.0,
                                                      color:
                                                          AppColors
                                                              .mainAppColor,
                                                    ),
                                              ),
                                            ),
                                        errorWidget:
                                            (context, url, error) =>
                                                const Icon(Icons.error),
                                        fadeInDuration: const Duration(
                                          seconds: 1,
                                        ),
                                        height: 90.h,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            currentLocale.languageCode == 'ar'
                                                ? item.productArName
                                                : item.categoryEnName,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.alexandria(
                                              textStyle: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 4.h),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text:
                                                      item.priceAfterDiscount
                                                          .toString(),
                                                  style: GoogleFonts.alexandria(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        AppColors.mainAppColor,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: 'currency'.tr(),
                                                  style: GoogleFonts.alexandria(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w300,
                                                    color:
                                                        AppColors.mainAppColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          if (item.price !=
                                              item.priceAfterDiscount)
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: item.price.toString(),
                                                    style:
                                                        GoogleFonts.alexandria(
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.red,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          decorationStyle:
                                                              TextDecorationStyle
                                                                  .dashed,
                                                          decorationColor:
                                                              Colors.red,
                                                          decorationThickness:
                                                              2.0,
                                                        ),
                                                  ),
                                                  TextSpan(
                                                    text: 'currency'.tr(),
                                                    style:
                                                        GoogleFonts.alexandria(
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          color: Colors.red,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          decorationStyle:
                                                              TextDecorationStyle
                                                                  .dashed,
                                                          decorationColor:
                                                              Colors.red,
                                                          decorationThickness:
                                                              2.0,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder:
                          (context, index) => const SizedBox(height: 10),
                    ),
                  ),
                ),
              ],
            );
          }

          if (state is SearchError) {
            return Center(
              child: SvgPicture.asset(
                AppAssets.notFound,
                width: 200.0,
                height: 200.0,
                fit: BoxFit.contain,
              ),
            );
          }

          return Center(
            child: SvgPicture.asset(
              AppAssets.notFound,
              width: 200.0,
              height: 200.0,
              fit: BoxFit.contain,
            ),
          );
        },
      ),
    );
  }
}
