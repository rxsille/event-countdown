import 'dart:async';
import 'package:countdown/model/event.dart';
import 'package:countdown/service/database.dart';

class EventBloc {

  EventBloc() {
    getAllEvents();
  }

  final _db = DatabaseService.instance;

  final _eventStream = StreamController<List<Event>>.broadcast();
  Stream<List<Event>> get events => _eventStream.stream;

  getAllEvents() async {
    _eventStream.sink.add(await _db.getAllEvents());
  }

  insertEvent(Event event) async {
    await _db.insertEvent(event);
    getAllEvents();
  }

  updateEvent(Event event) async {
    await _db.updateEvent(event);
    getAllEvents();
  }

  deleteEvent(int id) async {
    await _db.deleteEvent(id);
    getAllEvents();
  }

  dispose() {
    _eventStream.close();
  }

}