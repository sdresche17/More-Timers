import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moretimers/cubit/timerpopup_cubit.dart';
import 'package:moretimers/models/timer.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:moretimers/models/soundmap.dart';
import 'package:moretimers/models/uniqueid.dart';
import 'package:moretimers/cubit/list_cubit.dart';
import 'package:moretimers/models/repository.dart';

class NewTimerPopUp {
  final timer_type timer;
  String time;
  NewTimerPopUp({
    @required this.timer,
  });
  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSSSSS');
    final DateFormat serverFormater = DateFormat('HH:mm:ss');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  void colorDialog(BuildContext context, TimerpopupCubit _popupcubit) {
    showDialog(
        context: context,
        child: AlertDialog(
          title: const Text(
            'Pick a color!',
            style: TextStyle(color: Colors.blue),
          ),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: currentColor,
              onColorChanged: (color) {
                _popupcubit.setTimerColor(color);
                Navigator.of(context).pop();
              },
            ),
          ),
        ));
  }

  Color pickerColor = Colors.white;
  Color currentColor = Colors.white;
  double _fontSize = 28.0;
  double _cardSize = 60.0;
  void popUp(
    BuildContext context,
    formKey,
  ) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => BlocProvider.value(
        value: BlocProvider.of<ListCubit>(context),
        child: BlocBuilder<ListCubit, ListState>(builder: (context, liststate) {
          return BlocProvider(
            create: (context) => TimerpopupCubit(),
            child: BlocBuilder<TimerpopupCubit, TimerPopUpState>(
              builder: (context, state) {
                final _popupcubit = context.watch<TimerpopupCubit>();
                return AlertDialog(
                  title: Card(
                    color: Colors.blue[900],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          timer == timer_type.stopwatch
                              ? 'Create Stopwatch'
                              : 'Create Timer',
                          style: TextStyle(
                              fontSize: _fontSize,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  actions: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: RaisedButton(
                              elevation: 5,
                              color: Colors.blue[900],
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24),
                                ),
                              ),
                              onPressed: () {
                                BlocProvider.of<ListCubit>(context).add(
                                  TimerModel(
                                      id: uniqueid(),
                                      duration: timer == timer_type.stopwatch
                                          ? 0
                                          : _popupcubit.time,
                                      initialduration:
                                          timer == timer_type.stopwatch
                                              ? 0
                                              : _popupcubit.time,
                                      timer: timer,
                                      title: _popupcubit.title,
                                      color: _popupcubit.color.toString(),
                                      sound: _popupcubit.sound,
                                      endTime: DateTime.now().toString(),
                                      timerstate: "TimerInitial"),
                                );
                                _popupcubit.pauseTimerSound();
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: RaisedButton(
                              elevation: 5,
                              color: Colors.red[700],
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Close",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24),
                                ),
                              ),
                              onPressed: () {
                                _popupcubit.pauseTimerSound();
                                Navigator.pop(context);
                              },
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                  scrollable: true,
                  content: Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Title: ',
                                      style: TextStyle(
                                          fontSize: _fontSize,
                                          color: Colors.blue[900],
                                          decoration: TextDecoration.none),
                                    ),
                                    Spacer(),
                                    Container(
                                      width: 160,
                                      height: _cardSize,
                                      child: TextField(
                                          autofocus: false,
                                          onChanged: (text) =>
                                              _popupcubit.setTimerTitle(text),
                                          maxLength: 20,
                                          style: TextStyle(
                                              fontSize: _fontSize,
                                              decoration: TextDecoration.none,
                                              color: Colors.blue[900]),
                                          decoration: new InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                                left: 15,
                                                bottom: 0,
                                                top: 0,
                                                right: 15),
                                          )),
                                    )
                                  ]),
                              timer == timer_type.timer
                                  ? InkWell(
                                      onTap: () {
                                        DatePicker.showTimePicker(context,
                                            showTitleActions: true,
                                            showSecondsColumn: true,
                                            theme: DatePickerTheme(
                                                cancelStyle: TextStyle(
                                                    color: Colors.white),
                                                headerColor: Colors.blue[900],
                                                backgroundColor: Colors.white,
                                                itemStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                                doneStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16)),
                                            onChanged: (date) {
                                          time = date.toString();
                                        }, onConfirm: (date) {
                                          _popupcubit.setTimerTime(
                                              convertDateTimeDisplay(
                                                  date.toString()),
                                              timer);
                                        },
                                            currentTime: DateTime.parse(
                                                '2020-01-01 00:01:00.000'),
                                            locale: LocaleType.en);
                                      },
                                      child: Container(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Length: ',
                                            style: TextStyle(
                                                fontSize: _fontSize,
                                                color: Colors.blue[900]),
                                          ),
                                          Spacer(),
                                          Container(
                                            width: 160,
                                            height: _cardSize,
                                            child: Card(
                                              elevation: 5,
                                              child: Padding(
                                                padding: EdgeInsets.all(10),
                                                child: Text(
                                                  _popupcubit.timedisplay,
                                                  style: TextStyle(
                                                      fontSize: _fontSize),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )))
                                  : Container(),
                              InkWell(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Color: ',
                                      style: TextStyle(
                                          fontSize: _fontSize,
                                          color: Colors.blue[900]),
                                    ),
                                    Spacer(),
                                    Container(
                                      width: 160,
                                      height: _cardSize,
                                      child: Card(
                                          elevation: 5,
                                          color: _popupcubit.color,
                                          child: Container()),
                                    )
                                  ],
                                ),
                                onTap: () => colorDialog(context, _popupcubit),
                              ),
                              timer == timer_type.timer
                                  ? InkWell(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Sound: ',
                                            style: TextStyle(
                                                fontSize: _fontSize,
                                                color: Colors.blue[900]),
                                          ),
                                          Spacer(),
                                          Container(
                                              width: 160,
                                              height: _cardSize,
                                              child: Card(
                                                  elevation: 5,
                                                  child: Center(
                                                    child: DropdownButton(
                                                        onTap: () => _popupcubit
                                                            .pauseTimerSound(),
                                                        value:
                                                            _popupcubit.sound,
                                                        items: soundList.keys.map<
                                                            DropdownMenuItem<
                                                                String>>((String
                                                            value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: Text(value,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        _fontSize)),
                                                          );
                                                        }).toList(),
                                                        onChanged: (sound) =>
                                                            _popupcubit
                                                                .setTimerSound(
                                                                    sound)),
                                                  )))
                                        ],
                                      ),
                                      onTap: () =>
                                          _popupcubit.pauseTimerSound(),
                                    )
                                  : Container(),
                            ],
                          )),
                      // ))
                    ],
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
