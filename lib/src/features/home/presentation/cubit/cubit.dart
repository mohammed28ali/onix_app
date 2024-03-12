import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:onix_app/src/core/api/end_points.dart';

enum DeliveryState { initial, loading, success, failure }

class DeliveryCubit extends Cubit<DeliveryState> {
  final Dio dio = Dio();
  List<dynamic> deliveryData = [];

  DeliveryCubit() : super(DeliveryState.initial);

  Future<void> getDeliveryData() async {
    emit(DeliveryState.loading);
    try {
      final response = await dio.post(
        '${EndPoints.baseUrl}${EndPoints.getDeliveryBillsItems}',
        data: {
          "Value": {
            "P_DLVRY_NO": "1010",
            "P_LANG_NO": "1",
            "P_BILL_SRL": "",
            "P_PRCSSD_FLG": ""
          }
        },
      );
      if (response.statusCode == 200) {
        deliveryData = response.data['Data']['DeliveryBills'];
        emit(DeliveryState.success);
      } else {
        emit(DeliveryState.failure);
      }
    } catch (e) {
      emit(DeliveryState.failure);
    }
  }
}
