import 'package:flutter/material.dart';

class GroupDetailsPopupMenu extends StatelessWidget {
  const GroupDetailsPopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    List popUpMenuItems = ['Remove Member', 'Set as Admin', 'Dismiss as Admin'];
    return MenuAnchor(
      builder:
          (BuildContext context, MenuController controller, Widget? child) {
        return IconButton(
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: const Icon(Icons.more_horiz),
        );
      },
      alignmentOffset: const Offset(-80.0, 0.0),
      menuChildren: List<MenuItemButton>.generate(
        popUpMenuItems.length,
        (int index) => MenuItemButton(
          onPressed: () {
            callFunction(popUpMenuItems[index], context);
          },
          child: Text(popUpMenuItems[index]),
        ),
      ),
    );
  }

  callFunction(
    buttonName,
    context,
  ) {
    switch (buttonName) {
      case "Remove Member":
        print("Remove Member");
        break;
      case "Set as Admin":
        print("Set as Admin");
        break;
      case "Dismiss as Admin":
        print("Dismiss as Admin");
        break;
    }
  }
}
