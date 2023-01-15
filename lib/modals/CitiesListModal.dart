import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:taxizakaz/components/BAppBar.dart';
import 'package:taxizakaz/components/ListTile.dart';
import 'package:taxizakaz/modals/PlaceInputModal.dart';
import 'package:taxizakaz/stores/create-order-store.dart';
import 'package:taxizakaz/stores/order-store.dart';
import 'package:taxizakaz/stores/region-store.dart';
import 'package:taxizakaz/stores/user-store.dart';

class CitiesListModal extends StatefulWidget {
  const CitiesListModal({Key? key, required this.type}) : super(key: key);

  final String type;

  @override
  State<CitiesListModal> createState() => _CitiesListModalState();
}

class _CitiesListModalState extends State<CitiesListModal> {
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
    CreateOrderStore createOrderStore =
        Provider.of<CreateOrderStore>(context, listen: false);

    UserStore userStore = Provider.of<UserStore>(context, listen: false);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const BAppBar(title: 'Выберите город'),
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: CupertinoSearchTextField(
                onChanged: (String? value) {
                  regionStore.input_city = value;
                },
                placeholder: 'Искать',
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
                          createOrderStore.from_city_name =
                              regionStore.searched_cities[index].name;
                          createOrderStore.from_city_id =
                              regionStore.searched_cities[index].id;
                        }
                        if (widget.type == 'to_city') {
                          createOrderStore.to_city_name =
                              regionStore.searched_cities[index].name;
                          createOrderStore.to_city_id =
                              regionStore.searched_cities[index].id;
                        }

                        if (userStore.user?.type_user != null &&
                            userStore.user?.type_user == 2) {
                          var res = await openSecondModal(widget.type);

                          if (res == 'exit') {
                            if (mounted) {
                              Navigator.of(context).pop();
                            }
                          }
                        } else {
                          Navigator.of(context).pop();
                        }
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
        ));
  }
}
