import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import 'todo_created_for_list.dart';

class ToDoCreatedForListTile extends StatefulWidget {
  final Map todoMap;

  const ToDoCreatedForListTile({
    Key? key,
    required this.todoMap,
  }) : super(key: key);

  @override
  State<ToDoCreatedForListTile> createState() => _ToDoCreatedForListTileState();
}

class _ToDoCreatedForListTileState extends State<ToDoCreatedForListTile> {
  final List createdForList = [
    {"id": '1', "name": 'Aditya'},
    {"id": '2', "name": 'Rucha'},
    {"id": '3', "name": 'Aditi'},
    {"id": '4', "name": 'Animesh'},
    {"id": '5', "name": 'Aayushi'},
    {"id": '6', "name": 'Sumit'},
    {"id": '7', "name": 'Amit'},
    {"id": '8', "name": 'John'},
    {"id": '9', "name": 'Joe'},
    {"id": '10', "name": 'Phoebe'},
    {"id": '11', "name": 'Naruto'},
    {"id": '12', "name": 'Luffy'},
    {"id": '13', "name": 'Itachi'},
    {"id": '14', "name": 'Sauske'},
    {"id": '15', "name": 'Saturo Gojo'},
    {"id": '16', "name": 'Kakashi'}
  ];
  static List createdForNameList = [];
  static List createdForIdList = [];

  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: EdgeInsets.zero,
        onTap: () async {
          List selectedCreatedForList = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ToDoCreatedForList(
                        createdForList: createdForList,
                        onCreatedForChanged: (List id) {
                          createdForIdList = id;
                          widget.todoMap['createdfor'] = createdForIdList
                              .toString()
                              .replaceAll("[", "")
                              .replaceAll("]", "");
                        },
                      )));
          if (selectedCreatedForList.isNotEmpty) {
            createdForNameList.clear();
            setState(() {
              for (int i = 0; i < selectedCreatedForList.length; i++) {
                createdForNameList.add(selectedCreatedForList[i]);
              }
            });
          }
        },
        title: Text(DatabaseUtil.getText('createdfor'),
            style: Theme.of(context)
                .textTheme
                .medium
                .copyWith(color: AppColor.black)),
        subtitle: (createdForNameList.isEmpty)
            ? null
            : Padding(
                padding: const EdgeInsets.only(top: tiniestSpacing),
                child: Text(
                    createdForNameList
                        .toString()
                        .replaceAll("[", "")
                        .replaceAll("]", ""),
                    style: Theme.of(context)
                        .textTheme
                        .xSmall
                        .copyWith(color: AppColor.black)),
              ),
        trailing: const Icon(Icons.navigate_next_rounded, size: kIconSize));
  }
}
