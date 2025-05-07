// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:map_location_picker/map_location_picker.dart';
// import 'package:payhive/constants/urls.dart';
// import 'package:payhive/utils/screen_size.dart';
// import 'package:payhive/utils/widgets/button.dart';
// import '../../../utils/theme/apptheme.dart';
// import '../controller/address_controller.dart';
//
// class LocationPickerPage extends StatelessWidget {
//   final AddressController controller = Get.find<AddressController>();
//
//   LocationPickerPage({super.key});
//
//   GestureDetector backButton() {
//     return GestureDetector(
//       onTap: () {
//         Get.back();
//       },
//       child: Row(
//         children: [
//           Icon(
//             Icons.arrow_back_ios_rounded,
//             size: height / 18,
//             color: appColors.white,
//           ),
//           SizedBox(width: width / 80),
//           Text(
//             "Personal details",
//             style: theme.textTheme.labelMedium?.copyWith(
//               color: appColors.white,
//               fontWeight: FontWeight.w200,
//               fontSize: height / 20,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: true,
//       onPopInvokedWithResult: (b, t) async {
//         Get.back();
//       },
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         appBar: AppBar(
//             backgroundColor: appColors.primaryColor,
//             leadingWidth: width,
//             leading: Stack(
//               fit: StackFit.expand,
//               children: [
//                 Container(color: appColors.primaryColor),
//                 Container(
//                   margin: EdgeInsets.only(
//                     left: width / 30,
//                     bottom: width / 30,
//                     right: width / 30,
//                   ),
//                   alignment: Alignment.bottomLeft,
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       backButton(),
//                     ],
//                   ),
//                 ),
//               ],
//             )),
//         body: Stack(
//           children: [
//             MapLocationPicker(
//               apiKey: URLs.googleAPIKEY,
//               region: 'in',
//               fabIcon: Icons.my_location,
//               trafficEnabled: false,
//               mapType: MapType.normal,
//               onCameraIdle: () {},
//               onDecodeAddress: (result) async {
//                 controller.latitude.text =
//                     result!.geometry.location.lat.toString();
//                 controller.longitude.text =
//                     result.geometry.location.lng.toString();
//                 if (kDebugMode) {
//                   print(
//                       "${result.geometry.location.lat},${result.geometry.location.lng}");
//                 }
//               },
//               currentLatLng:
//                   LatLng(controller.currentLat, controller.currentLong),
//               topCardMargin: const EdgeInsets.all(16),
//               decoration: InputDecoration(
//                 icon: Padding(
//                   padding: const EdgeInsets.only(left: 12.0),
//                   child: Icon(
//                     Icons.search,
//                     color: appColors.primaryColor,
//                   ),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(4),
//                   borderSide: const BorderSide(
//                     color: Colors.transparent,
//                     width: 1,
//                   ),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(4),
//                   borderSide: const BorderSide(
//                     color: Colors.transparent,
//                     width: 1,
//                   ),
//                 ),
//                 hintText: "Search Your Address",
//               ),
//               topCardShape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(4),
//               ),
//               bottomCardBuilder: (context, result, val) {
//                 if (result?.formattedAddress != null) {
//                   controller.titleAddressToShow.value =
//                       result!.addressComponents.first.shortName.toString();
//                   controller.fullAddressToShow.value = result.formattedAddress.toString()!;
//
//                   return const SizedBox();
//                 } else {
//                   return const SizedBox();
//                 }
//               },
//               hideBackButton: true,
//               hideMapTypeButton: true,
//               onNext: (GeocodingResult? result) {
//                 if (result != null) {
//                   controller.landmark.text = result.formattedAddress!;
//                   controller.address.text = result.formattedAddress!;
//                 }
//               },
//               onSuggestionSelected: (PlacesDetailsResponse? result) {
//                 if (result != null) {
//                   controller.landmark.text = result.result.formattedAddress!;
//                   controller.address.text = result.result.formattedAddress!;
//                 }
//               },
//             ),
//             Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: Container(
//                 padding: EdgeInsets.all(height / 12),
//                 height: height / 1.4,
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       "YOUR CURRENTLY SELECTED ADDRESS",
//                       style: TextStyle(
//                           color: Colors.blue, fontWeight: FontWeight.w400),
//                     ),
//                     SizedBox(height: height / 40),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.location_on,
//                               color: appColors.primaryLight,
//                               size: height / 18,
//                             ),
//                             Text(controller.titleAddressToShow.value.toString(),
//                                 style: TextStyle(
//                                     fontSize: height / 18,
//                                     fontWeight: FontWeight.w600)),
//                           ],
//                         ),
//                         Text("CHANGE",
//                             style: TextStyle(
//                                 color: appColors.primaryLight,
//                                 fontWeight: FontWeight.w600)),
//                       ],
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(left: width / 17),
//                       child: Text(controller.fullAddressToShow.value.toString()),
//                     ),
//                     Container(
//                       margin: const EdgeInsets.symmetric(
//                           horizontal: 4, vertical: 12),
//                       padding: const EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         color: Colors.yellow[100],
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                       child: const Text(
//                           "The address is 338 m away from your current location"),
//                     ),
//                     customButton(
//                         title: 'Add more address details',
//                         context: context,
//                         onTap: () {
//                           controller
//                               .parseAddress(controller.fullAddressToShow.value);
//                           Get.back();
//                         }),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
