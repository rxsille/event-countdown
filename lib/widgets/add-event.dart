import 'package:countdown/bloc/event_bloc.dart';
import 'package:countdown/bloc/event_logic.dart';
import 'package:countdown/model/event.dart';
import 'package:countdown/shared/logic.dart';
import 'package:flutter/material.dart';
import 'package:countdown/shared/constant.dart' as constant;
import 'package:flutter_svg/flutter_svg.dart';

class AddEvent {

  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  final _imageController = TextEditingController();

  final key = GlobalKey<FormState>();

  String _date;

  void addEventDialog(BuildContext context, EventBloc bloc, Event event) {

    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    if(event != null) {
      _nameController.text = event.name;
      _dateController.text = EventLogic().formatDate(event.date);
      _imageController.text = event.image;
      _date = event.date;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.all(0),
          content: Stack(
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: _height * 0.1,
                    color: Colors.transparent,
                  ),
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(_height * 0.04),
                      color: Colors.white
                    ),
                    height: _height * 0.45,
                    child: Form(
                      key: key,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(height: _height * 0.1),
                          _eventNameField(),
                          SizedBox(height: 10.0),
                          _eventDatePicker(context),
                          SizedBox(height: 10.0),
                          _eventImageField(),
                          SizedBox(height: 30.0),
                          FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)
                            ),
                            color: constant.violet,
                            onPressed: (){
                              if(key.currentState.validate()) {
                                bloc.insertEvent(
                                  Event(
                                    name: _nameController.text,
                                    date: _date,
                                    image: _imageController.text
                                  )
                                ).whenComplete(() => 
                                  Navigator.pop(context));
                              }
                            },
                            child: Container(
                              width: _width,
                              height: _height * 0.05,
                              child: Center(
                                child: Text('Save',
                                  style: TextStyle(
                                    color: Colors.white
                                  )))),
                          )
                        ],
                      ),
                    ),
                  ),
                  
                ],
              ),
              SvgPicture.asset('assets/camping.svg',
                height: _height * 0.2)
            ],
          ),
        );
      }
    );
  }

  TextFormField _eventNameField() {
    return TextFormField(
      decoration: constant.form.copyWith(labelText: 'Event Name'),
      controller: _nameController,
      cursorColor: constant.black,
      validator: (value){
        if(value.isEmpty) return '';
        return null;
      },
    );
  }

  TextFormField _eventImageField() {
    return TextFormField(
      decoration: constant.form.copyWith(labelText: 'Background'),
      controller: _imageController,
      cursorColor: constant.black,
    );
  }

  TextFormField _eventDatePicker(BuildContext context) {
    return TextFormField(
      decoration: constant.form.copyWith(labelText: 'Date'),
      controller: _dateController,
      onTap: () async {
        DateTime date = DateTime(DateTime.now().year);
        FocusScope.of(context).requestFocus(FocusNode());
        date = await showDatePicker(
          context: context, 
          initialDate: DateTime.now(), 
          firstDate: DateTime(DateTime.now().year), 
          lastDate: DateTime(2100),
          builder: (context, child) {
            return Theme(
              child: child,
              data: ThemeData(
                primaryColor: constant.violet,
                accentColor: constant.black,
                colorScheme: ColorScheme.light(
                  primary: constant.violet
                )
              )
            );
          }
        );
        _date = date.toIso8601String();
        _dateController.text = date == null ? '' : formatDate(date);
      },
      cursorColor: constant.black,
      validator: (value){
        if(value.isEmpty) return '';
        return null;
      },
    );
  }

}