import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:payhive/modules/list_pos_req/controller/list_pos_controller.dart';
import 'package:payhive/modules/list_pos_req/model/all_pos_request.dart';
import 'package:payhive/routes/pages.dart';
import 'package:payhive/utils/screen_size.dart';
import 'package:payhive/utils/theme/apptheme.dart';
import 'package:payhive/utils/widgets/button.dart';

class ListPosRequest extends GetView<ListPosController> {
  const ListPosRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.white,
      appBar: appBar(),
      body: GetBuilder(
          init: controller,
          builder: (ctx) {
            return controller.loading.value
                ? Center(
                    child: Lottie.asset('assets/lottie/wave_loading.json',
                        width: width, height: height / 2.5),
                  )
                : SizedBox(
                    height: MediaQuery.sizeOf(context).height,
                    width: MediaQuery.sizeOf(context).width,
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width,
                          height: MediaQuery.sizeOf(context).height / 18,
                          child: TabBar(
                            controller: controller.tabController,
                            tabs: controller.tabs,

                            labelColor:
                                Colors.deepPurple, // Active tab text color
                            unselectedLabelColor:
                                Colors.black, // Inactive tab text color
                            indicatorColor:
                                appColors.primaryColor, // Underline color
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: appColors.primaryColor),
                            unselectedLabelStyle: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: appColors.black),
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: controller.tabController,
                            children: [
                              _buildTransactionList(
                                  controller.pending, 'Pending'),
                              _buildTransactionList(
                                  controller.approved, 'Approved'),
                              _buildTransactionList(
                                  controller.rejected, 'Rejected'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
          }),
    );
  }

  Widget _buildTransactionList(List<PosRequestItem> list, String status) {
    return list.isEmpty
        ? Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(bottom: height / 20),
            child: Text(
              "NO DATA AVAILABLE",
              style: theme.textTheme.labelMedium?.copyWith(
                color: appColors.grey,
                letterSpacing: 1,
                fontWeight: FontWeight.w900,
                fontSize: height / 18,
              ),
            ),
          )
        : RefreshIndicator(
            onRefresh: () async {
              controller.getAllPosList();
            },
            child: ListView.builder(
              itemCount: list.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {},
                    child: _transactionItem(
                        list[index], index, status, list, context));
              },
            ),
          );
  }

  Widget _transactionItem(
      PosRequestItem item, int index, status, list, context) {
    return Container(
      margin: EdgeInsets.only(
          left: width / 30,
          right: width / 30,
          top: height / 30,
          bottom: index == list.length - 1 ? height / 30 : 0),
      padding: EdgeInsets.all(width / 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border:
            Border.all(color: appColors.primaryColor.withValues(alpha: 0.25)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "R.R.N : ${item.rrnNumber.toString().toUpperCase()}",
                style: theme.textTheme.labelMedium?.copyWith(
                  color: appColors.black.withValues(alpha: 0.35),
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2,
                  fontSize: height / 22,
                ),
              ),
              status != 'Approved'
                  ? Padding(
                      padding: EdgeInsets.only(
                        left: height / 40,
                      ),
                      child: customButton(
                        passedHeight: height / 14,
                        passedWidth: width / 5,
                        title: status == 'Pending' ? 'Edit' : 'Resubmit',
                        border: Border.all(color: appColors.white, width: 0.35),
                        context: context,
                        onTap: () {
                          Get.toNamed(Routes.posRequest, arguments: item)!
                              .then((v) {
                            controller.getAllPosList();
                          });
                        },
                      ),
                    )
                  : const SizedBox(),
            ],
          ),

          SizedBox(height: height / 50),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       "P.O.S Request Status ",
          //       style: theme.textTheme.labelMedium?.copyWith(
          //         color: appColors.black.withValues(alpha: 0.8),
          //         letterSpacing: 2,
          //         fontWeight: FontWeight.w500,
          //         fontSize: height / 36,
          //       ),
          //     ),
          //     Container(
          //       padding:
          //           const EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
          //       decoration: BoxDecoration(
          //           color: status == 'Pending'
          //               ? Colors.orange
          //               : status == 'Approved'
          //                   ? Colors.green
          //                   : Colors.red,
          //           borderRadius: BorderRadius.circular(2)),
          //       child: Text(
          //         status == 'Pending'
          //             ? "Pending"
          //             : status == 'Approved'
          //                 ? "Approved"
          //                 : "Rejected",
          //         style: theme.textTheme.labelMedium?.copyWith(
          //           color: appColors.white,
          //           fontWeight: FontWeight.w500,
          //           fontSize: height / 36,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Serial Number : ${item.serialno}',
                style: theme.textTheme.labelMedium?.copyWith(
                  letterSpacing: 1,
                  fontWeight: FontWeight.w500,
                  fontSize: height / 28,
                ),
              ),
            ],
          ),
          SizedBox(height: height / 80),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Amount ',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: appColors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: height / 32,
                    ),
                  ),
                  Text(
                    '₹${item.amount ?? '00/00/0000'}',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: appColors.green,
                      fontWeight: FontWeight.w500,
                      fontSize: height / 24,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: height / 60,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Card type :",
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: appColors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: height / 30,
                    ),
                  ),
                  Text(
                    " ${item.cardTypeName}".toUpperCase(),
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: appColors.green,
                      fontWeight: FontWeight.w400,
                      fontSize: height / 28,
                    ),
                  ),
                ],
              ),
              Text(
                "TID ${item.tid}",
                style: theme.textTheme.labelMedium?.copyWith(
                  color: appColors.primaryColor,
                  fontWeight: FontWeight.w400,
                  fontSize: height / 30,
                ),
              ),
            ],
          ),
          SizedBox(
            height: height / 90,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Transaction Date : ${DateFormat(
                  "d MMMM, yyyy",
                ).format(DateFormat("dd/MM/yyyy").parse(item.transactionDate ?? '00/00/0000')).toString()}',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: appColors.black.withValues(alpha: 0.6),
                  fontWeight: FontWeight.w400,
                  fontSize: height / 28,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget _transactionItem(PosRequestItem item, int index, status, list) {
  //   return Container(
  //     margin: EdgeInsets.only(
  //         left: width / 30,
  //         right: width / 30,
  //         top: height / 30,
  //         bottom: index == list.length - 1 ? height / 30 : 0),
  //     padding: EdgeInsets.all(width / 30),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(8),
  //       border:
  //           Border.all(color: appColors.primaryColor.withValues(alpha: 0.25)),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.grey.withValues(alpha: 0.2),
  //           spreadRadius: 5,
  //           blurRadius: 7,
  //           offset: const Offset(0, 3), // changes position of shadow
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //
  //         /// SERIAL NUMBER
  //
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               "P.O.S Request Status ",
  //               style: theme.textTheme.labelMedium?.copyWith(
  //                 color: appColors.black.withValues(alpha: 0.8),
  //                 letterSpacing: 2,
  //                 fontWeight: FontWeight.w500,
  //                 fontSize: height / 36,
  //               ),
  //             ),
  //             Container(
  //               padding:
  //                   const EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
  //               decoration: BoxDecoration(
  //                   color: status == 'Pending'
  //                       ? Colors.orange
  //                       : status == 'Approved'
  //                           ? Colors.green
  //                           : Colors.red,
  //                   borderRadius: BorderRadius.circular(60)),
  //               child: Text(
  //                 status == 'Pending'
  //                     ? "Pending"
  //                     : status == 'Approved'
  //                         ? "Approved"
  //                         : "Rejected",
  //                 style: theme.textTheme.labelMedium?.copyWith(
  //                   color: appColors.white,
  //                   fontWeight: FontWeight.w500,
  //                   fontSize: height / 36,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //
  //         SizedBox(height: height / 60),
  //
  //         RichText(
  //           text: TextSpan(
  //             text: "CARD NETWORK - ",
  //             style: theme.textTheme.labelMedium?.copyWith(
  //               color: appColors.black,
  //               letterSpacing: 2,
  //               fontWeight: FontWeight.w400,
  //               fontSize: height / 38,
  //             ),
  //             children: [
  //               TextSpan(
  //                 text: item.cardtype?.toUpperCase() ?? '',
  //                 style: theme.textTheme.labelMedium?.copyWith(
  //                   color: appColors.primaryColor,
  //                   letterSpacing: 2,
  //                   fontWeight: FontWeight.w800,
  //                   fontSize: height / 32,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         SizedBox(height: height / 90),
  //
  //         RichText(
  //           text: TextSpan(
  //             text: "Serial NO. ",
  //             style: theme.textTheme.labelMedium?.copyWith(
  //               color: appColors.black,
  //               letterSpacing: 2,
  //               fontWeight: FontWeight.w400,
  //               fontSize: height / 38,
  //             ),
  //             children: [
  //               TextSpan(
  //                 text: item.serialNumber.toString().toUpperCase(),
  //                 style: theme.textTheme.labelMedium?.copyWith(
  //                   color: appColors.black.withValues(alpha: 0.35),
  //                   fontWeight: FontWeight.w900,
  //                   letterSpacing: 3,
  //                   fontSize: height / 32,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //
  //         SizedBox(height: height / 90),
  //         RichText(
  //           text: TextSpan(
  //             text: "R.R.N.       ",
  //             style: theme.textTheme.labelMedium?.copyWith(
  //               color: appColors.black,
  //               letterSpacing: 2,
  //               fontWeight: FontWeight.w400,
  //               fontSize: height / 38,
  //             ),
  //             children: [
  //               TextSpan(
  //                 text: item.rrnNumber.toString().toUpperCase(),
  //                 style: theme.textTheme.labelMedium?.copyWith(
  //                   color: appColors.black.withValues(alpha: 0.35),
  //                   fontWeight: FontWeight.w900,
  //                   letterSpacing: 3,
  //                   fontSize: height / 32,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //
  //         SizedBox(height: height / 60),
  //
  //         /// AMOUNT
  //
  //         RichText(
  //           text: TextSpan(
  //             text: "Amount.    ",
  //             style: theme.textTheme.labelMedium?.copyWith(
  //               color: appColors.black,
  //               letterSpacing: 2,
  //               fontWeight: FontWeight.w400,
  //               fontSize: height / 38,
  //             ),
  //             children: [
  //               TextSpan(
  //                 text: '₹${item.amount ?? ''}',
  //                 style: theme.textTheme.labelMedium?.copyWith(
  //                   color: Colors.green,
  //                   fontWeight: FontWeight.w900,
  //                   letterSpacing: 3,
  //                   fontSize: height / 24,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //
  //
  //
  //
  //         /// AMOUNT
  //
  //         SizedBox(height: height / 60),
  //
  //
  //
  //
  //         SizedBox(height: height / 30),
  //
  //         /// CARD NETWORK
  //
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.end,
  //           children: [
  //             Text(
  //               'Transaction Date : ${DateFormat("d MMMM, yyyy").format(DateFormat("dd/MM/yyyy").parse(item.transactionDate ?? '00/00/0000'))}',
  //               style: theme.textTheme.labelMedium?.copyWith(
  //                 color: appColors.black.withOpacity(0.5),
  //                 fontWeight: FontWeight.w400,
  //                 fontSize: height / 40,
  //               ),
  //               textAlign: TextAlign.right,
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _transactionItem(PosRequestItem item, int index, status, list) {
  //   return Container(
  //     margin: EdgeInsets.only(
  //       left: width / 30,
  //       right: width / 30,
  //       top: height / 40,
  //       bottom: index == list.length - 1 ? height / 30 : 0,
  //     ),
  //     padding: EdgeInsets.all(width / 25),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(12),
  //       border: Border.all(
  //         color: appColors.primaryColor.withOpacity(0.1),
  //       ),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.grey.withOpacity(0.15),
  //           spreadRadius: 2,
  //           blurRadius: 8,
  //           offset: const Offset(0, 4),
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         /// Top Row: RRN & Status
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               "RRN : ${item.rrnNumber.toString().toUpperCase()}",
  //               style: theme.textTheme.labelMedium?.copyWith(
  //                 color: appColors.black,
  //                 fontWeight: FontWeight.w700,
  //                 fontSize: height / 30,
  //               ),
  //             ),
  //             Container(
  //               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
  //               decoration: BoxDecoration(
  //                 color: status == 'Pending'
  //                     ? Colors.orange
  //                     : status == 'Approved'
  //                     ? Colors.green
  //                     : Colors.red,
  //                 borderRadius: BorderRadius.circular(20),
  //               ),
  //               child: Text(
  //                 status,
  //                 style: theme.textTheme.labelMedium?.copyWith(
  //                   color: Colors.white,
  //                   fontWeight: FontWeight.w500,
  //                   fontSize: height / 50,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //
  //         const SizedBox(height: 6),
  //
  //         /// Serial Number
  //         Text(
  //           'Serial Number : ${item.serialNumber}',
  //           style: theme.textTheme.labelMedium?.copyWith(
  //             color: Colors.grey[700],
  //             fontWeight: FontWeight.w400,
  //             fontSize: height / 38,
  //           ),
  //         ),
  //
  //         const SizedBox(height: 10),
  //
  //         /// Amount & TID
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             RichText(
  //               text: TextSpan(
  //                 text: 'Amount ',
  //                 style: theme.textTheme.labelMedium?.copyWith(
  //                   color: appColors.black,
  //                   fontWeight: FontWeight.w400,
  //                   fontSize: height / 36,
  //                 ),
  //                 children: [
  //                   TextSpan(
  //                     text: '₹${item.amount ?? ''}',
  //                     style: theme.textTheme.labelMedium?.copyWith(
  //                       color: appColors.green,
  //                       fontWeight: FontWeight.w600,
  //                       fontSize: height / 30,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             Text(
  //               "TID ${item.tid}",
  //               style: theme.textTheme.labelMedium?.copyWith(
  //                 color: appColors.primaryColor,
  //                 fontWeight: FontWeight.w500,
  //                 fontSize: height / 36,
  //               ),
  //             ),
  //           ],
  //         ),
  //
  //         const SizedBox(height: 10),
  //
  //         /// Card type & Transaction date
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             RichText(
  //               text: TextSpan(
  //                 text: "Card network - ",
  //                 style: theme.textTheme.labelMedium?.copyWith(
  //                   color: appColors.black,
  //                   fontWeight: FontWeight.w400,
  //                   fontSize: height / 38,
  //                 ),
  //                 children: [
  //                   TextSpan(
  //                     text: item.cardtype?.toUpperCase() ?? '',
  //                     style: theme.textTheme.labelMedium?.copyWith(
  //                       color: appColors.primaryColor,
  //                       fontWeight: FontWeight.w800,
  //                       fontSize: height / 36,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             Text(
  //               'Transaction Date : ${DateFormat("d MMMM, yyyy").format(DateFormat("dd/MM/yyyy").parse(item.transactionDate ?? '00/00/0000'))}',
  //               style: theme.textTheme.labelMedium?.copyWith(
  //                 color: appColors.black.withOpacity(0.5),
  //                 fontWeight: FontWeight.w400,
  //                 fontSize: height / 40,
  //               ),
  //               textAlign: TextAlign.right,
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  AppBar appBar() {
    return AppBar(
      backgroundColor: appColors.primaryColor,
      leadingWidth: width,
      leading: Container(
        alignment: Alignment.bottomLeft,
        padding: EdgeInsets.only(bottom: width / 30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            backButton(),
          ],
        ),
      ),
    );
  }

  GestureDetector backButton() {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Row(
        children: [
          SizedBox(width: width / 30),
          Icon(
            Icons.arrow_back_ios_new_rounded,
            size: height / 14,
            color: appColors.white,
          ),
          SizedBox(width: width / 80),
          Text(
            " All P.O.S Requests",
            style: theme.textTheme.labelMedium?.copyWith(
              color: appColors.white,
              letterSpacing: 1,
              fontWeight: FontWeight.w400,
              fontSize: height / 22,
            ),
          ),
        ],
      ),
    );
  }
}
