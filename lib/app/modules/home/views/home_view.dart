import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';
import 'package:todo_one/app/config/assets.gen.dart';
import 'package:todo_one/app/config/colors.dart';
import 'package:todo_one/app/config/utils.dart';
import 'package:todo_one/app/data/hive_service.dart';

import '../../../data/note_model.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Hôm nay'),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(Assets.icons.icSearch)),
            IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(Assets.icons.icCalendar))
          ],
          flexibleSpace: Container(
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.only(bottomLeft: Radius.circular(20)),
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[
                    AppColors.blue,
                    AppColors.lightBlue,
                  ]),
            ),
          ),
        ),
        drawer: Drawer(
          backgroundColor: AppColors.grey,
          child: ListView(
            children: [
              const Gap(30),
              Container(
                height: 74,
                width: 74,
                decoration: const BoxDecoration(
                    color: Colors.white, shape: BoxShape.circle),
                child: const Center(
                  child: Icon(Icons.person, size: 40, color: Colors.grey),
                ),
              ),
              const Gap(16),
              const Text(
                'Xin chào',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              const Gap(16),
              const Divider(color: Colors.white),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 17, vertical: 16),
                child: Row(
                  children: [
                    SvgPicture.asset(Assets.icons.icCalendar),
                    const Gap(21),
                    const Text(
                      'Hôm nay',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              const Divider(color: Colors.white),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 17, vertical: 16),
                child: Row(
                  children: [
                    SvgPicture.asset(Assets.icons.icList),
                    const Gap(21),
                    const Text(
                      'Danh sách',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    const Spacer(),
                    const Icon(Icons.add, color: Colors.white)
                  ],
                ),
              )
            ],
          ),
        ),
        body: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HiveService _hiveService;
  bool isLoading = false;
  late List<Note> _listNote;

  @override
  void initState() {
    super.initState();
    _hiveService = Get.find();
    getAllNote();
  }

  getAllNote() async {
    setState(() {
      isLoading = true;
    });
    _listNote = await _hiveService.getAll();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: Get.find<Box<Note>>().listenable(),
        builder: (context, box, widget) {
          final List<Note> listNote = box.values.toList().cast<Note>();

          final List<Note> listUndone =
              listNote.where((note) => !note.isDone).toList();
          final List<Note> listDone =
              listNote.where((note) => note.isDone).toList();

          return Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          InkWell(
                              onTap: () {
                                _hiveService.changeAllNoteStatus(true);
                              },
                              child: const Icon(Icons.check_box_outlined,
                                  color: Color(0xFFD9D9D9))),
                          const Gap(15),
                          const Text(
                            'Chưa hoàn thành',
                            style: TextStyle(
                                color: Color(0xFF848484),
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      )
                    ),
                    const Gap(15),
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              child: Row(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        _hiveService.changeNoteStatus(
                                            listUndone[index].key, true
                                        );
                                      },
                                      child: const Icon(Icons.check_box_outlined,
                                          color: Color(0xFFD9D9D9))),
                                  const Gap(22),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          listUndone[index].title,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        const Gap(4),
                                        Text(
                                          Utils.formatDate(
                                              listUndone[index].date),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Gap(22),
                                  InkWell(
                                    onTap: () {

                                    },
                                    child: Row(
                                      children: const [
                                        Icon(Icons.access_time_sharp, color: Colors.red, size: 13),
                                        Gap(10),
                                        Text(
                                          'Nhắc nhở',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (_, __) => const Divider(),
                          itemCount: listUndone.length),
                    )
                  ],
                ),
              ),
              const Divider(thickness: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Đã hoàn thành',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      _hiveService.changeNoteStatus(
                                          listDone[index].key, false
                                      );
                                    },
                                    child: const Icon(Icons.check_box,
                                        color: Color(0xFFD9D9D9)),
                                  ),
                                  const Gap(22),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          listDone[index].title,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        const Gap(4),
                                        Text(
                                          Utils.formatDate(
                                              listDone[index].date),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (_, __) => const Divider(),
                          itemCount: listDone.length),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await _hiveService.add(Note(
                      title: 'tititileeeeeee',
                      content:
                          'contentcontentcontentcontentcontentcontentcontentcontentcontent',
                      isDone: false,
                      date: DateTime.now(),
                      category: 'List 1'));
                },
                child: Container(
                  margin: const EdgeInsets.all(26),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(33),
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: <Color>[
                          AppColors.blue,
                          AppColors.lightBlue,
                        ]),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.white)),
                        child: const Icon(Icons.add, color: Colors.white),
                      ),
                      const Gap(15),
                      const Text(
                        'Lời nhắc mới',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
