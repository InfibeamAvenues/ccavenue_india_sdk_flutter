class CCAvenueOrderModel {
  // Required fields
  final String accessCode;
  final String encRequest; 
  final String appColor;
  final String fontColor;
  final String paymentEnvironment;   // "qa" or "production" or "uat"

  CCAvenueOrderModel({
    required this.accessCode,
    required this.encRequest,
    this.appColor = "#1F46BD",
    this.fontColor = "#FFFFFF",
    this.paymentEnvironment = 'production', // Default to production as per Kotlin snippet defaults
  });

  Map<String, dynamic> toMap() {
    return {
      "accessCode": accessCode,
      "encRequest": encRequest,
      "appColor": appColor,
      "fontColor": fontColor,
      "paymentEnvironment": paymentEnvironment,
    };
  }
}


// accesscode,encreq,fontcolor,appcolor 