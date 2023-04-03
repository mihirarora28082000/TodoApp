import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:todoapp/bloc/todo_bloc.dart';
import 'package:todoapp/data/models/task.dart';

String _labelSlider(int priority) {
  if (priority == 1) {
    return "Low";
  } else if (priority == 2) {
    return "Medium";
  } else {
    return "High";
  }
}

Color color(int priority) {
  if (priority == 1) {
    return Colors.red;
  } else if (priority == 2) {
    return Colors.brown;
  }
  return Colors.green;
}

Future<void> showModal(
  BuildContext context,
  Function setState, {
  DateTime? dateInputText,
  String descriptionText = '',
  String titleText = '',
  double sliderValueDefault = 1,
  String? idText,
}) {
  double sliderValue = sliderValueDefault;
  TextEditingController description =
      TextEditingController(text: descriptionText);
  TextEditingController title = TextEditingController(text: titleText);
  DateTime? pickedDate = dateInputText ?? DateTime.now();
  TextEditingController dateInput =
      TextEditingController(text: DateFormat('dd-MM-yyyy').format(pickedDate));
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: ((ctx) {
        return Container(
          color: Colors.grey[150],
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          height: MediaQuery.of(context).orientation == Orientation.landscape
              ? MediaQuery.of(context).size.height * 0.8
              : MediaQuery.of(context).size.height * 0.7,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.today_outlined),
                  title: TextField(
                    style: titleText != ''
                        ? const TextStyle(color: Colors.grey)
                        : null,
                    readOnly: titleText == '' ? false : true,
                    controller: title,
                    decoration: InputDecoration(
                      errorText: title.text == ''
                          ? 'Email field can\'t be empty'
                          : null,
                      hintText: "Title",
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.description),
                  title: TextField(
                    controller: description,
                    decoration: const InputDecoration(
                      hintText: "Description",
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.date_range),
                  title: TextField(
                    readOnly: true,
                    controller: dateInput,
                    decoration: const InputDecoration(
                      hintText: "Pick Date",
                    ),
                    onTap: () async {
                      pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100));
                      if (pickedDate != null) {
                        String formattedDate = DateFormat('dd-MM-yyyy')
                            .format(pickedDate ?? DateTime.now());
                        setState(() {
                          dateInput.text = formattedDate;
                        });
                      }
                    },
                  ),
                ),
                const Text('Priority'),
                StatefulBuilder(builder: (context, setStateBuilder) {
                  return Slider(
                      max: 3,
                      min: 1,
                      divisions: 2,
                      value: sliderValue.toDouble(),
                      label: _labelSlider(sliderValue.toInt()),
                      activeColor: color(4 - sliderValue.toInt()),
                      onChanged: (double sliderValueOnChanged) {
                        setStateBuilder(() {
                          sliderValue = sliderValueOnChanged;
                        });
                      });
                }),
                ElevatedButton(
                    onPressed: title.text == ''
                        ? null
                        : () {
                            if (title.text == '') {
                              return;
                            }
                            context.read<TodoBloc>().add(AddTask(
                                    task: TodoTask(
                                  id: idText ??
                                      DateTime.now()
                                          .microsecondsSinceEpoch
                                          .toString(),
                                  description: description.text,
                                  name: title.text,
                                  priority: 4 - sliderValue.toInt(),
                                  date: pickedDate ?? DateTime.now(),
                                  isCompleted: false,
                                )));
                            Navigator.of(context).pop();
                          },
                    child: titleText == '' ? const Text('SUBMIT') : const Text('UPDATE')),
              ],
            ),
          ),
        );
      }));
}
