import 'package:payhive/constants/urls.dart';
import 'package:payhive/services/network/api_result.dart';
import 'package:payhive/services/network/network.dart';

class DashboardRepo {
  Network network = Network();

  Future<ApiResults> userData({mobileNumber}) async {
    return await network.getData(
      endPoint: URLs.getUserData,
      queryParameters: {'mobileno': mobileNumber.toString()},
    );
  }

  Future<ApiResults> getDashboardData() async {
    return await network.getData(
      endPoint: URLs.getDashboardData,
    );
  }

  Future<ApiResults> getWalletHistory() async {
    return await network.getData(
      endPoint: URLs.walletHistory,
    );
  }

  Future<ApiResults> generateOrderId(amount) async {
    return await network.postData(endPoint: URLs.generateOrderId, data: {
      'amount': amount,
    });
  }

  Future<ApiResults> sendPaymentDetails({
    required String status,
    required String amount,
    required String orderId,
    required String paymentCat,
    required String settlementType,
    String? paymentId,
  }) async {
    return await network.postDataWithJson(
      endPoint: URLs.sendPaymentDetailToServer,
      data: {
        "payment_status_from_app": status,
        "amount": amount,
        "currency": "INR",
        "pay_id": paymentId.toString(),
        "order_id": orderId.toString(),
        "payment_category": paymentCat.toString(),
        "settlement_type": settlementType.toString(),
      },
    );
  }
}
