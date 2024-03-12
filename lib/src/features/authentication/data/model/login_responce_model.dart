class LoginResponse {
  final String deliveryName;
  final String errMsg;
  final int errNo;

  LoginResponse(
      {required this.deliveryName, required this.errMsg, required this.errNo});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      deliveryName: json['Data']['DeliveryName'],
      errMsg: json['Result']['ErrMsg'],
      errNo: json['Result']['ErrNo'],
    );
  }
}
