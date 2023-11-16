// ignore_for_file: prefer_generic_function_type_aliases

typedef void EventCallback(arg);

class EventBus {
  EventBus._internal();

  static final EventBus _singleton = EventBus._internal();

  factory EventBus() => _singleton;

  final _emap = <Object, List<EventCallback>>{};

  void on(eventName, EventCallback? f) {
    if (eventName == null || f == null) return;
    _emap[eventName] ??= [];
    _emap[eventName]!.add(f);
  }

  void off(eventName, [EventCallback? f]) {
    var list = _emap[eventName];
    if (eventName == null || list == null) return;
    if (f == null) {
      // ignore: null_check_always_fails
      _emap[eventName] = [];
    } else {
      list.remove(f);
    }
  }

  void emit(eventName, [arg]) {
    var list = _emap[eventName];
    if (list == null) return;
    int len = list.length - 1;

    for (var i = len; i > -1; --i) {
      list[i](arg);
    }
  }
}

var bus = EventBus();
