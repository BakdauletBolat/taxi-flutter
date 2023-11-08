import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:taxizakaz/components/BAppBar.dart';
import 'package:taxizakaz/components/ListTile.dart';
import 'package:taxizakaz/hooks/showModal.dart';
import 'package:taxizakaz/models/city.dart';
import 'package:taxizakaz/stores/user-store.dart';

class ListModal extends StatefulWidget {
  const ListModal(
      {Key? key,
      required this.items,
      this.placeWidget,
      this.withPlace = true,
      required this.onClick})
      : super(key: key);

  final List items;
  final Function onClick;
  final Widget? placeWidget;
  final bool withPlace;

  @override
  State<ListModal> createState() => _ListModalState();
}

class _ListModalState extends State<ListModal> {
  List items = [];

  @override
  void initState() {
    items = widget.items;
    super.initState();
  }

  void searchItems(String? value) {
    if (value == null || value.isEmpty) {
      setState(() {
        items = widget.items;
      });
    }
    setState(() {
      items = widget.items
          .where((element) =>
              element.name.toLowerCase().startsWith(value!.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    UserStore userStore = Provider.of<UserStore>(context, listen: false);

    void clickDriver(item) {
      widget.onClick(item);
      Navigator.of(context).pop();
    }

    void clickWithPlace(item) async {
      widget.onClick(item);
      
      var res = await showModal(
            context, widget.placeWidget!);
        if (res == 'exit') {
          if (mounted) {
            Navigator.of(context).pop();
          }
        }
    }

    void clickByUser(int? typeUser, item) {
      if (item is Region && item.cities.isNotEmpty) {
        setState(() {
          items = item.cities;
        });
        return;
      }
      if (typeUser != null && typeUser == 2 && widget.withPlace) {
        clickWithPlace(item);
      } else {
        clickDriver(item);
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const BAppBar(title: 'Выберите город'),
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: CupertinoSearchTextField(
                onChanged: searchItems,
                placeholder: 'Искать',
              ),
            ),
            Observer(builder: (context) {
              return ListView.builder(
                  itemCount: items.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        clickByUser(userStore.user?.type_user, items[index]);
                      },
                      child: BListTile(
                        city_name: items[index].name,
                      ),
                    );
                  });
            })
          ]),
        ));
  }
}
