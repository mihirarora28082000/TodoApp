import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:todoapp/data/models/task.dart';
import 'package:todoapp/presentation/bloc/todo_bloc.dart';
import 'package:todoapp/presentation/constants/colors.dart';
import 'package:todoapp/presentation/constants/label_names.dart';
import 'package:todoapp/presentation/utils/slider_label.dart';
import 'package:todoapp/presentation/utils/task_priority_color.dart';

Future<void> showModal(BuildContext context, Function setState,
    {DateTime? dateInputText,
    String descriptionText = '',
    String titleText = '',
    double sliderValueDefault = 1,
    String? idText}) {
  double sliderValue = sliderValueDefault;
  TextEditingController description =
      TextEditingController(text: descriptionText);
  TextEditingController title = TextEditingController(text: titleText);
  DateTime? pickedDate = dateInputText ?? DateTime.now();
  TextEditingController dateInput =
      TextEditingController(text: DateFormat('dd-MM-yyyy').format(pickedDate));

  var mediaQuery = MediaQuery.of(context);
  TextField emailInputBox() {
    return TextField(
        style: titleText != '' ? const TextStyle(color: Colors.grey) : null,
        readOnly: titleText == '' ? false : true,
        controller: title,
        decoration: InputDecoration(
            errorText: title.text == '' ? EMAIL_CANT_BE_EMPTY : null,
            hintText: TASK_TITLE_HINT_TEXT));
  }

  TextField descriptionInputBox() {
    return TextField(
        controller: description,
        decoration:
            const InputDecoration(hintText: TASK_DESCRIPTION_HINT_TEXT));
  }

  TextField dateInputBox() {
    return TextField(
        readOnly: true,
        controller: dateInput,
        decoration: const InputDecoration(hintText: TASK_PICK_DATE),
        onTap: () async {
          pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2100));
          if (pickedDate != null) {
            String formattedDate =
                DateFormat('dd-MM-yyyy').format(pickedDate ?? DateTime.now());
            setState(() {
              dateInput.text = formattedDate;
            });
          }
        });
  }

  ElevatedButton onSubmitButton() {
    return ElevatedButton(
        style:
            ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor),
        onPressed: title.text == ''
            ? null
            : () {
                if (title.text == '') {
                  return;
                }
                context.read<TodoBloc>().add(AddTask(
                    task: TodoTask(
                        id: idText ??
                            DateTime.now().microsecondsSinceEpoch.toString(),
                        description: description.text,
                        name: title.text,
                        priority: sliderValue.toInt(),
                        date: pickedDate ?? DateTime.now(),
                        isCompleted: false)));
                Navigator.of(context).pop();
              },
        child: titleText == '' ? const Text(SUBMIT) : const Text(UPDATE));
  }

  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: ((ctx) {
        return Container(
            color: lightGrey,
            padding: EdgeInsets.only(bottom: mediaQuery.viewInsets.bottom),
            height: mediaQuery.orientation == Orientation.landscape
                ? mediaQuery.size.height * 0.8
                : mediaQuery.size.height * 0.7,
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
              ListTile(
                  leading: const Icon(Icons.today_outlined),
                  title: emailInputBox()),
              ListTile(
                  leading: const Icon(Icons.description),
                  title: descriptionInputBox()),
              ListTile(
                  leading: const Icon(Icons.date_range), title: dateInputBox()),
              const Text(SLIDER_TITLE),
              StatefulBuilder(builder: (context, setStateBuilder) {
                return Slider(
                    max: 3,
                    min: 1,
                    divisions: 2,
                    value: sliderValue.toDouble(),
                    label: labelSlider(sliderValue.toInt()),
                    activeColor: taskPriorityColor(sliderValue.toInt()),
                    onChanged: (double sliderValueOnChanged) {
                      setStateBuilder(() {
                        sliderValue = sliderValueOnChanged;
                      });
                    });
              }),
              onSubmitButton()
            ])));
      }));
}
