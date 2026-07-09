class CCAvenueOrder {
  // Required fields
  final String accessCode;
  final String encRequest; 
  final String appColor;
  final String fontColor;
  final String paymentEnvironment;
  final String encryptionMode;

  CCAvenueOrder({
    required this.accessCode,
    required this.encRequest,
    this.appColor = "#1F46BD",
    this.fontColor = "#FFFFFF",
    this.paymentEnvironment = 'production',
    this.encryptionMode = 'aes128',
  });

  Map<String, dynamic> toMap() {
    return {
      "accessCode": accessCode,
      "encRequest": encRequest,
      "appColor": appColor,
      "fontColor": fontColor,
      "paymentEnvironment": paymentEnvironment,
      "encryptionMode": encryptionMode,
    };
  }
}