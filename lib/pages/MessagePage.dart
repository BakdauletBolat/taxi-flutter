import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:taxizakaz/components/BAppBar.dart';
import 'package:taxizakaz/models/message.dart';
import 'package:taxizakaz/stores/user-store.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  void initState() {
    UserStore userStore = Provider.of<UserStore>(context, listen: false);
    userStore.loadUserMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserStore userStore = Provider.of<UserStore>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 239, 239),
      appBar: const BAppBar(
        title: 'Сообщение',
        type: 'transparent',
      ),
      body: RefreshIndicator(
        onRefresh: userStore.loadUserMessages,
        child: Stack(
          children: [
            Container(
              color: Colors.white10,
              height: MediaQuery.of(context).size.height,
            ),
            Observer(builder: (context) {
              return ListView.separated(
                  padding: const EdgeInsets.all(20),
                  shrinkWrap: true,
                  separatorBuilder: ((context, index) =>
                      const Divider(color: Colors.transparent)),
                  itemCount: userStore.userMessages.length,
                  itemBuilder: (context, index) =>
                      MessageItem(message: userStore.userMessages[index]));
            }),
          ],
        ),
      ),
    );
  }
}

class MessageItemDivider extends StatelessWidget {
  MessageItemDivider({Key? key, required this.date}) : super(key: key);

  final DateTime date;

  final DateFormat formatter = DateFormat('dd.MM.yy');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Text(formatter.format(date)),
    );
  }
}

class MessageItem extends StatelessWidget {
  const MessageItem({Key? key, required this.message}) : super(key: key);

  final Message message;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MessageItemDivider(date: message.created_at),
        const SizedBox(
          height: 20,
        ),
        Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      message.title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Text(message.text),
              ],
            )),
      ],
    );
  }
}
