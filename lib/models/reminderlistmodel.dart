import 'package:oldisgold/models/remindermodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ReminderListModel {
  List<ReminderModel> reminderList = [];

  addReminderList() {
    ReminderModel reminderModel = ReminderModel("title ${reminderList.length}",
        "this is the task no detail ${reminderList.length}");
    reminderList.add(reminderModel);

    // notifyListeners();
  }
}
