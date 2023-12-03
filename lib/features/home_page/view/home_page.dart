import 'package:auto_route/annotations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat/data/model/chat_model.dart';
import 'package:flutter_chat/features/chat_page/view/chat_page.dart';
import 'package:flutter_chat/features/home_page/controller/chatpod.dart';
import 'package:flutter_chat/main.dart';
import 'package:flutter_chat/router/auto_router_pod.dart';
import 'package:flutter_chat/router/router.gr.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State {
  FirebaseAuth auth = FirebaseAuth.instance;
  final chatModel = <ChatModel>[
    ChatModel(
      imagePath:
          "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50",
      chatName: "Kiran Kamla",
      messageDate: "29/10/23",
      messageSubtittle: "testMessage",
    ),
    ChatModel(
      imagePath:
          "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50",
      chatName: "Kiran Kamla",
      messageDate: "29/10/23",
      messageSubtittle: "testMessage",
    ),
    ChatModel(
      imagePath:
          "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50",
      chatName: "Kiran Kamla",
      messageDate: "29/10/23",
      messageSubtittle: "testMessage",
    ),
    ChatModel(
      imagePath:
          "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50",
      chatName: "Kiran Kamla",
      messageDate: "29/10/23",
      messageSubtittle: "testMessage",
    ),
    ChatModel(
      imagePath:
          "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50",
      chatName: "Kiran Kamla",
      messageDate: "29/10/23",
      messageSubtittle: "testMessage",
    ),
    ChatModel(
      imagePath:
          "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50",
      chatName: "Kiran Kamla",
      messageDate: "29/10/23",
      messageSubtittle: "testMessage",
    ),
    ChatModel(
      imagePath:
          "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50",
      chatName: "Kiran Kamla",
      messageDate: "29/10/23",
      messageSubtittle: "testMessage",
    ),
    ChatModel(
      imagePath:
          "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50",
      chatName: "Kiran Kamla",
      messageDate: "29/10/23",
      messageSubtittle: "testMessage",
    ),
    ChatModel(
      imagePath:
          "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50",
      chatName: "Kiran Kamla",
      messageDate: "29/10/23",
      messageSubtittle: "testMessage",
    ),
    ChatModel(
      imagePath:
          "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50",
      chatName: "Kiran Kamla",
      messageDate: "29/10/23",
      messageSubtittle: "testMessage",
    ),
    ChatModel(
      imagePath:
          "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50",
      chatName: "Kiran Kamla",
      messageDate: "29/10/23",
      messageSubtittle: "testMessage",
    ),
    ChatModel(
      imagePath:
          "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50",
      chatName: "Kiran Kamla",
      messageDate: "29/10/23",
      messageSubtittle: "testMessage",
    ),
    ChatModel(
      imagePath:
          "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50",
      chatName: "Kiran Kamla",
      messageDate: "29/10/23",
      messageSubtittle: "testMessage",
    ),
    ChatModel(
      imagePath:
          "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50",
      chatName: "Kiran Kamla",
      messageDate: "29/10/23",
      messageSubtittle: "testMessage",
    ),
    ChatModel(
      imagePath:
          "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50",
      chatName: "Kiran Kamla",
      messageDate: "29/10/23",
      messageSubtittle: "testMessage",
    ),
    ChatModel(
      imagePath:
          "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50",
      chatName: "Kiran Kamla",
      messageDate: "29/10/23",
      messageSubtittle: "testMessage",
    ),
    ChatModel(
      imagePath:
          "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50",
      chatName: "Kiran Kamla",
      messageDate: "29/10/23",
      messageSubtittle: "testMessage",
    ),
    ChatModel(
      imagePath:
          "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50",
      chatName: "Kiran Kamla",
      messageDate: "29/10/23",
      messageSubtittle: "testMessage",
    ),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: Color(0xFF075E54),
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                  leadingWidth: 200,
                  backgroundColor: const Color(0xFF075E54),
                  leading: const Padding(
                    padding: EdgeInsets.only(left: 23, top: 20),
                    child: Text(
                      "WhatsApp",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.camera_alt_outlined),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              scale: 2,
                              "https://img.freepik.com/premium-vector/business-global-economy_24877-41082.jpg")),
                    ).onTap(() async {
                      await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: "Do you Want to Logout".text.make(),
                          actions: [
                            Consumer(
                              builder: (context, ref, child) {
                                return TextButton(
                                  onPressed: () async {
                                    await auth.signOut().then((value) => ref
                                        .read(autrouterPod)
                                        .replaceAll([const LoginRoute()]));
                                  },
                                  child: "OK".text.make(),
                                );
                              },
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: "NO".text.make())
                          ],
                        ),
                      );
                    })
                  ]),
              Consumer(
                builder: (_, WidgetRef ref, __) {
                  final data = ref.watch(dataProvider);

                  return data.when(
                    data: (data) {
                      logger.good(data);
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          childCount: chatModel.length,
                          (context, index) => SizedBox(
                            height: 60,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatPage(
                                      imagePath: chatModel[index].imagePath,
                                      chatName: chatModel[index].chatName,
                                    ),
                                  ),
                                );
                              },
                              child: ListTile(
                                leading: SizedBox(
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        chatModel[index].imagePath),
                                  ),
                                ),
                                title: Text(
                                  chatModel[index].chatName,
                                  style: const TextStyle(color: Colors.black),
                                ),
                                subtitle: Text(
                                  chatModel[index].messageSubtittle,
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                trailing: Text(
                                  chatModel[index].messageDate,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    error: (error, stackTrace) =>
                        SliverToBoxAdapter(child: Text(error.toString())),
                    loading: () => SliverToBoxAdapter(
                        child: const CircularProgressIndicator()
                            .h(30)
                            .w(30)
                            .centered()),
                  );
                },
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF075E54),
          child: const Icon(
            Icons.message,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        bottomNavigationBar: BottomNavigationBar(
          // selectedLabelStyle:
          //     const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          // selectedIconTheme: const IconThemeData(color: Colors.black),
          selectedItemColor: Colors.black,
          // unselectedLabelStyle:
          //     const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          // showUnselectedLabels: true,
          unselectedIconTheme: const IconThemeData(color: Colors.grey),
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
              label: "Chats",
              icon: Icon(
                Icons.message,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.update,
              ),
              label: "Updates",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.groups,
              ),
              label: "Communities",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.call,
              ),
              label: "Calls",
            )
          ],
        ),
      ),
    );
  }
}
