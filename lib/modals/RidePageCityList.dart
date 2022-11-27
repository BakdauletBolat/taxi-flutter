import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:taxizakaz/components/BAppBar.dart';
import 'package:taxizakaz/components/ListTile.dart';
import 'package:taxizakaz/modals/PlaceInputModal.dart';
import 'package:taxizakaz/stores/order-store.dart';
import 'package:taxizakaz/stores/region-store.dart';

class RidePageCityList extends StatefulWidget {
  const RidePageCityList({Key? key, required this.type, this.type_order_id})
      : super(key: key);

  final String type;
  final int? type_order_id;

  @override
  State<RidePageCityList> createState() => _CitiesListModalState();
}

class _CitiesListModalState extends State<RidePageCityList> {
  Future<String> openSecondModal(String type) async {
    var res = await showCupertinoModalBottomSheet(
      context: context,
      expand: false,
      builder: (context) => PlaceInputModal(type: type),
    );
    return res.toString();
  }

  @override
  Widget build(BuildContext context) {
    RegionStore regionStore = Provider.of<RegionStore>(context, listen: false);
    OrderStore orderStore = Provider.of<OrderStore>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const BAppBar(title: 'Выберите город'),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: CupertinoSearchTextField(
              placeholder: 'Искать',
              onChanged: (String? value) {
                regionStore.input_city = value;
              },
            ),
          ),
          Observer(builder: (context) {
            return ListView.builder(
                itemCount: regionStore.searched_cities.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      if (widget.type == 'from_city') {
                        orderStore.from_city_id =
                            regionStore.searched_cities[index].id;
                        orderStore.from_city_name =
                            regionStore.searched_cities[index].name;
                      }
                      if (widget.type == 'to_city') {
                        orderStore.to_city_id =
                            regionStore.searched_cities[index].id;
                        orderStore.to_city_name =
                            regionStore.searched_cities[index].name;
                      }

                      orderStore.loadOrders(type_order: widget.type_order_id);

                      Navigator.of(context).pop();
                    },
                    child: BListTile(
                      region_name:
                          regionStore.searched_cities[index].region!.name,
                      city_name: regionStore.searched_cities[index].name,
                    ),
                  );
                });
          })
        ]),
      ),
    );
  }
}
