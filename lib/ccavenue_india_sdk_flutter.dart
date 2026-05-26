import 'ccavenue_india_sdk_flutter_platform_interface.dart';
import 'ccavenue_order_model.dart'; // Exporting this so user can access Model

export 'ccavenue_order_model.dart';

class CCAvenueSDK { 
  Future<String?> initTransaction(CCAvenueOrder order) {
    if (order.encRequest.isEmpty) {
      throw Exception("EncRequest cannot be empty");
    }
    if (order.accessCode.isEmpty) {
      throw Exception("Access Code cannot be empty");
    }
    return CcavenueIndiaSdkPlatform.instance.payCCAvenue(order.toMap());
  }
}