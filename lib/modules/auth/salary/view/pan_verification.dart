// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';
// import 'package:payhive/modules/auth/salary/bloc/salary_bloc.dart';
// import 'package:payhive/modules/auth/salary/view/pan_details.dart';
// import 'package:payhive/services/di/di.dart';
// import 'package:payhive/utils/widgets/button.dart';
// import 'package:payhive/utils/widgets/textfield.dart';
// import 'package:percent_indicator/percent_indicator.dart';
// import 'package:payhive/utils/screen_size.dart';
// import 'package:payhive/utils/theme/apptheme.dart';
//
// class PanVerifySalaried extends StatefulWidget {
//   const PanVerifySalaried({super.key});
//
//   @override
//   State<PanVerifySalaried> createState() => _PanVerifySalariedState();
// }
//
// class _PanVerifySalariedState extends State<PanVerifySalaried> {
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: appColors.primaryColor,
//       body: BlocConsumer<SalaryBloc, SalaryState>(
//         bloc: salaryBloc,
//         listener: (context, state) {
//           if (state is PanFormValidateSuccess) {
//             salaryBloc.add(SalariedAPIEvent(step: '5'));
//           } else if (state is PanDetailsFetchedSuccessfully) {
//             Get.to(()=> const PanDetails());
//           }
//         },
//         builder: (context, state) {
//           return body(context, state);
//         },
//       ),
//     );
//   }
//
//   SafeArea body(BuildContext context, SalaryState state) {
//     return SafeArea(
//       child: Container(
//         margin: EdgeInsets.only(top: height / 100),
//         width: MediaQuery.sizeOf(context).width,
//         height: MediaQuery.sizeOf(context).height,
//         alignment: Alignment.center,
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage("assets/images/splash_bg.png"),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: SafeArea(
//           child: Column(
//             children: [
//               progress(),
//               spacing(passedHeight: height / 7),
//               text(),
//               spacer(),
//               pan(context, state)
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Spacer spacer() => const Spacer();
//
//   bool isTermChecked = false;
//
//   Container pan(BuildContext context, state) {
//     return Container(
//       height: MediaQuery.sizeOf(context).height / 1.35,
//       width: width,
//       decoration: BoxDecoration(
//         color: appColors.white,
//         borderRadius: BorderRadius.only(
//           topRight: Radius.circular(height / 16),
//           topLeft: Radius.circular(height / 16),
//         ),
//       ),
//       child: Stack(
//         children: [
//           Padding(
//             padding: EdgeInsets.only(left: width / 20, right: width / 20),
//             child: Form(
//               key: salaryBloc.formKeyPan,
//               child: Column(
//                 children: [
//                   spacing(),
//                   customTextField(
//                     textEditingController: salaryBloc.panController,
//                     title: "Pan Number",
//                     keyboardType: TextInputType.text,
//                   ),
//                   spacing(passedHeight: height / 40),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 3.0),
//                     child: InkWell(
//                       onTap: () {
//                         salaryBloc.add(
//                           TermCheckPressedPan(
//                             isChecked: state is! TermCheckedPan,
//                           ),
//                         );
//                       },
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Image.asset(
//                             state is TermCheckedPan
//                                 ? "assets/icons/checkbox.png"
//                                 : "assets/icons/blank_checkbox.png",
//                             height: height / 24,
//                             fit: BoxFit.contain,
//                           ),
//                           SizedBox(width: width / 60),
//                           Expanded(
//                             child: Text(
//                               "I am aware that my details will be submitted to NSDL to verify my PAN. I have read and understood all terms.",
//                               style: theme.textTheme.bodySmall?.copyWith(
//                                 color: const Color(0xff222222),
//                                 fontSize: height / 30,
//                                 fontWeight: FontWeight.normal,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   spacer(),
//                   customButton(
//                       title: "Verify",
//                       context: context,
//                       onTap: () {
//                         salaryBloc.add(ValidatePanEvent(context));
//                       }),
//                   spacing(passedHeight: height / 8),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: -height / 8,
//             child: IgnorePointer(
//               ignoring: true,
//               child: Image.asset(
//                 "assets/images/home_flare.png",
//                 width: width,
//                 height: height / 1.75,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Container text() {
//     return Container(
//       alignment: Alignment.centerLeft,
//       padding: EdgeInsets.only(
//         top: width / 20,
//         left: width / 20,
//         right: width / 20,
//       ),
//       child: Text(
//         "Enter Your\nPAN Number",
//         style: theme.textTheme.headlineSmall
//             ?.copyWith(color: appColors.white, fontWeight: FontWeight.w600),
//       ),
//     );
//   }
//
//   SizedBox spacing({passedHeight}) =>
//       SizedBox(height: passedHeight ?? height / 20);
//
//   LinearPercentIndicator progress() {
//     return LinearPercentIndicator(
//       width: width,
//       animation: true,
//       animationDuration: 2000,
//       padding: EdgeInsets.zero,
//       lineHeight: height / 100,
//       percent: 0.5,
//       backgroundColor: appColors.primaryExtraLight,
//       progressColor: appColors.green,
//     );
//   }
// }
