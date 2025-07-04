
import 'package:alpharapp/Feature/Auth/login/screen/login_screen.dart';
import 'package:alpharapp/Feature/main/Home/home_screen.dart';
import 'package:alpharapp/core/constans/app_colors.dart';
import 'package:flutter/material.dart';
import '../../core/constans/app_assets.dart';
import '../../core/constans/constants.dart';
import '../../core/sharde/widget/navigation.dart';
import 'choose_country.dart';



class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds:5 ),(){





      if(beasUrlCairoOrMa!='')
      {
        if(customerid!=null)
        {
          // GoRouter.of(context).pushReplacement('/home');

          // context.go('/home');
          navigatofinsh(context,  const HomeScreen(), false);

        }
        else
          {
            navigatofinsh(context,  const LoginScreen(), false);
          }

    }
      else
      {
      navigatofinsh(context,  const ChooseBranchScreen(), false);
      }


    },);
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: AppColors.mainAppColor,
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: -1, end: 0),
          duration: const Duration(seconds: 3),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, value * MediaQuery.of(context).size.height),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Padding(
                    padding:const EdgeInsets.symmetric(horizontal: 50),
                    child: Image.asset(AppAssets.logo),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
