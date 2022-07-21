import 'package:taxiflutter/api/api-service.dart';
import 'package:taxiflutter/models/city.dart';
import 'package:taxiflutter/models/create-order.dart';

class CreateOrderService extends ApiService {
  Future<String> create(CreateOrder order) async {
    var res = await api.post('/order/order-create/', data: order);
    print(res.data);
    return 'asd';
  }
}
