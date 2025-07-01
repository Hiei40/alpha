import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constans/app_colors.dart';

class MainCategoryCard extends StatelessWidget {
  final String imagePath;
  final String categoryName;
  final double? width;
  final double? hieght;

  const MainCategoryCard({
    super.key,
    required this.imagePath,
    required this.categoryName,
    this.width,
    this.hieght,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: hieght ?? 90,
            width: width ?? 90,
            alignment: Alignment.center,
            child: CachedNetworkImage(
              imageUrl: imagePath,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(
                  value: 1.0,
                  color: AppColors.mainAppColor,
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            width: width ?? 90,
            alignment: Alignment.center,
            child: Text(
              categoryName,
              textAlign: TextAlign.center,
              style: GoogleFonts.alexandria(
                fontSize: 12.5.sp, // قللنا الحجم شوية
                fontWeight: FontWeight.w500,
                height: 1.0,
                color: const Color(0xff5C5C5C),
              ),
              maxLines: 2, // خليها ثابتة 3 لأن بعض العناوين طويلة جدًا
              overflow: TextOverflow.ellipsis,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
