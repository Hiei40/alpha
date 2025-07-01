import 'package:alpharapp/Feature/main/Add%20Order/model/all_address_model.dart';
import 'package:alpharapp/Feature/main/Add%20Order/screen/widget/order_summry.dart';
import 'package:alpharapp/core/sharde/widget/navigation.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constans/app_colors.dart';
import '../../../../core/constans/constants.dart';
import '../../../../core/network/local/cachehelper.dart';
import '../../../../core/sharde/widget/default_button.dart';
import '../../../../core/sharde/widget/text_forn_field.dart';
import '../../cart/screen/manager/cart_cubit.dart';
import '../../cart/screen/model/cart_item_model.dart' as cart;
import '../manager/add_order_cubit.dart';
import '../manager/add_order_state.dart';
import 'widget/dotted_divider_painter.dart';

class AddOrderScreen extends StatelessWidget {
  double total;
  dynamic listItem;
  AllAddressModel allAddressModel;
  final String address;
  final List<cart.CartItem> listItemName;
  AddOrderScreen({
    required this.listItemName,
    super.key,
    required this.total,
    required this.listItem,
    required this.allAddressModel, required this.address,
  });

  double finalValue = 0.0;

  double discountValue = 0;

  var keyForm = GlobalKey<FormState>();

  final discountCodeController = TextEditingController();

  final notes = TextEditingController();

  @override
  Widget build(BuildContext context) {
    currentLang = CacheHelper.getData(key: 'changeLang') ?? 'ar';
    final currentLocale = context.locale;
    return Scaffold(
      backgroundColor: const Color(0xffEFF2F7),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        toolbarHeight: 40.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'complete_order'.tr(),
          style: GoogleFonts.alexandria(
            color: AppColors.mainAppColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Form(
            key: keyForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                5.verticalSpace,
                Text(
                  'do_you_have_discount_code'.tr(),
                  style: GoogleFonts.alexandria(
                    textStyle: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color:Colors.black,
                    ),
                  ),
                ),
                10.verticalSpace,
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child:  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: CustomTextFormField(
                          paddingN: 0,
                          borderColor: Colors.white,
                          fillColor: Colors.white,

                          hintText: 'enter_discount_code'.tr(),
                          textInputType: TextInputType.name,

                          validator: (value) {

                            if (value == null || value.isEmpty) {
                              return 'please_enter_discount_code'.tr();
                            }




                            return null;
                          },
                          controller: discountCodeController,



                        ),
                      ),
                      const SizedBox(width: 5,),
                      Expanded(
                        flex: 1,
                        child:

                        BlocConsumer<AddOrderCubit,AddOrderState>(
                          listener: (context,state)
                          {
                            if(state is GetDiscountError)
                            {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(

                                      'coupon_used_before'.tr()
                                  ),
                                  backgroundColor: Colors.red,
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            }

                            if(state is GetDiscountSuccess)
                            {
                              if(BlocProvider.of<AddOrderCubit>(context).discountList[0].discountValue!>0)
                              {
                                discountValue=BlocProvider.of<AddOrderCubit>(context).discountList[0].discountValue!;
                              }
                              else
                              {


                                discountValue=
                                    total*((BlocProvider.of<AddOrderCubit>(context).discountList[0].discountPercent?.toDouble()??0.0)/100)
                                ;



                              }


                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(

                                      'discount_code_activated_successfully'.tr()
                                  ),
                                  backgroundColor: Colors.green,
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            }

                          },
                          builder: (context,state)
                          {
                            return  ConditionalBuilder(
                              condition:state is !GetDiscountLoading  ,
                              builder:(context){
                                return      DefaultButton(

                                  backgroundColor:AppColors.mainAppColor,
                                  text: 'activate'.tr(),function: (){
                                  if (keyForm.currentState!.validate()) {

                                    BlocProvider.of<AddOrderCubit>(context).getDiscount(codeDiscount: discountCodeController.text);
                                  }


                                },);
                              } ,
                              fallback:(context){
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.mainAppColor,
                                    strokeWidth: 1.0,
                                  ),
                                );

                              } ,

                            );
                          },

                        ),
                      ),
                    ],
                  ),
                ),
                20.verticalSpace,
                Text(
                  'payment_method'.tr(),
                  style: GoogleFonts.alexandria(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                10.verticalSpace,
                Row(
                  children: [
                    Radio<bool>(
                      activeColor: AppColors.mainAppColor,
                      value: true,
                      groupValue: true,
                      onChanged: (value) {},
                    ),
                    Text(
                      'cash_on_delivery'.tr(),
                      style: GoogleFonts.alexandria(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                10.verticalSpace,


                40.verticalSpace,

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPriceRow(context, 'subtotal'.tr(), total),
                    4.verticalSpace,
                    _buildPriceRow(context, 'delivery_fee'.tr(), double.tryParse(allAddressModel.deliveryValue.toString()) ?? 0.0),
                    4.verticalSpace,
                    _buildPriceRow(context, 'discount_value'.tr(), BlocProvider.of<AddOrderCubit>(context).discountList.isNotEmpty ? discountValue : 0.0),
                    10.verticalSpace,
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CustomPaint(
                        painter: DottedDividerPainter(),
                        child: Container(height: 1),
                      ),
                    ),
                    10.verticalSpace,
                    _buildPriceRow(
                      context,
                      'total'.tr(),
                      (total - (BlocProvider.of<AddOrderCubit>(context).discountList.isNotEmpty ? discountValue : 0.0)) + (double.tryParse(allAddressModel.deliveryValue ?? '0') ?? 0.0),
                    ),
                  ],
                ),
                10.verticalSpace,
                Row(
                  children: [

                    Text(
                     "please_enter_notes".tr(),
                      style: GoogleFonts.alexandria(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),

                10.verticalSpace,
                Container(
                  padding: const EdgeInsets.all(10), // Add padding to TextField
                  decoration: BoxDecoration(
                    color:
                    AppColors.white, // Background color for note effect
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                  width: MediaQuery.of(context).size.width*.9, // Adjust width as per your requirement
                  height: 80.h, // Adjust height as per your requirement
                  child: TextField(
                    controller: notes,
                    maxLines: 10, // Allowing multiple lines of text
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13.sp,
                          color: AppColors.black,
                          fontFamily: GoogleFonts.alexandria().fontFamily),
                      hintText: "notes".tr(), // Placeholder text
                      border: InputBorder.none, // Remove border
                    ),
                  ),
                ),
                50.verticalSpace,

                10.verticalSpace,

                BlocConsumer<AddOrderCubit, AddOrderState>(
                  listener: (context, state) {
                    if (state is AddOrderSuccess) {
                      navigatofinsh(
                        context,
                        OrderSummery(
                          orderSummryModel: state.orderSummryModel!,
                          listItemName: listItemName, id: state.id,
                        ),
                        false,
                      );

                      context.read<CartCubit>().clearCart();
                      Fluttertoast.showToast(
                        msg: 'order_success'.tr(),
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: AppColors.mainAppColor,
                        textColor: Colors.white,
                        fontSize: 16.0,
                        webBgColor: "linear-gradient(to right, #00b09b, #96c93d)",
                        webPosition: "center",
                      );

                    }
                    if (state is AddOrderError) {
                      Fluttertoast.showToast(
                        msg: 'order_error'.tr(),
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.NONE,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                        webBgColor: "linear-gradient(to right, #00b09b, #96c93d)",
                        webPosition: "center",
                      );

                    }
                  },
                  builder: (context, state) {
                    return ConditionalBuilder(
                      condition: state is! AddOrderLoading,
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DefaultButton(
                            function: () {
                              BlocProvider.of<AddOrderCubit>(context).addOrder(
                                discountCode: discountCodeController.text,
                                regionName: allAddressModel.regionName,
                                customerAddress: address?? '',
                                customName: allAddressModel.arabicName,
                                districtName: allAddressModel.districtName2,
                                email: allAddressModel.email,
                                listItem: listItem, // this is the JSON-formatted map
                                total: total,
                                addition: num.parse(allAddressModel.deliveryValue?.toString() ?? '0'),
                                discount: BlocProvider.of<AddOrderCubit>(context).discountList.isEmpty ? 0.0 : discountValue, notes: notes.text,
                              );
                            },
                            text: 'complete_order'.tr(),
                          ),
                        );
                      },
                      fallback: (context) => const Center(child: CircularProgressIndicator()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPriceRow(BuildContext context, String label, double amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.alexandria(
            color: Colors.black,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: amount.toStringAsFixed(2),
                style: GoogleFonts.alexandria(
                  fontSize: 13.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const WidgetSpan(child: SizedBox(width: 8)),
              TextSpan(
                text: 'currency'.tr(),
                style: GoogleFonts.alexandria(
                  fontSize: 8.sp,
                  color: AppColors.mainAppColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
