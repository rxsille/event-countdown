
import 'dart:async';

import 'package:countdown/bloc/event_bloc.dart';
import 'package:countdown/bloc/event_logic.dart';
import 'package:countdown/model/event.dart';
import 'package:countdown/widgets/add-event.dart';
import 'package:countdown/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:countdown/shared/constant.dart' as constant;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final bloc = EventBloc();


  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Event Countdown',
          style: TextStyle(color: constant.black)),
      ),
      body: StreamBuilder<List<Event>>(
        stream: bloc.events,
        builder: (context, snapshot) {
          if(!snapshot.hasData) return Loading();
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              if(!EventLogic().isComplete(snapshot.data[index].date)) return Container();
              return _eventCard(_height, _width, snapshot.data[index]);
          });
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: constant.violet,
        elevation: 1,
        onPressed: () {
          AddEvent().addEventDialog(context, bloc, null);
        }),
    );
  }

  Widget _eventCard(double _height, double _width, Event _event) {

    String _placeholder = 'https://images.unsplash.com/photo-1590314760437-474671af4bec?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2102&q=80';

    return Container(
      height: _height * 0.25,
      width: _width,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(_event.image.isEmpty ? _placeholder : _event.image)
        ),
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: _height * 0.03,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit), 
                  color: Colors.white,
                  onPressed: (){
                    AddEvent().addEventDialog(context, bloc, _event);
                }),
                IconButton(
                  icon: Icon(Icons.clear), 
                  color: Colors.white,
                  onPressed: (){
                    bloc.deleteEvent(_event.id);
                  }),
              ],
            ),
          ),
          Text('${_event.name}',
            style: TextStyle(
              fontSize: _height * 0.02,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [Shadow(
                color: Colors.black)]
          )),
          Text(EventLogic().formatDate(_event.date),
            style: TextStyle(
              color: Colors.white
            )),
          Container(
            margin: EdgeInsets.symmetric(vertical: 15.0),
            height: _height * 0.12,
            child: StreamBuilder(
              stream: Stream.periodic(Duration(seconds: 1), (i) => i),
              builder: (context, snapshot) {
                return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(5.0),
                    width: _width * 0.2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Center(
                      child: Text(EventLogic().getCountdown(_event.date)[index].toString(),
                        style: TextStyle(
                          fontSize: _height * 0.04
                        )),
                    ),
                  );
                });
              }
            ),
          ),
        ],
      ),
    );
  }

  
}