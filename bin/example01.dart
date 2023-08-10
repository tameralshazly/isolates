import 'dart:isolate';

void main(List<String> args) async {
  await for (var message in getMessages().take(10)) {
    print(message);
  }
}

Stream<String> getMessages() async* {
  final rp = ReceivePort();
  await Isolate.spawn(_getMessages, rp.sendPort);

  await for (var msg
      in rp.takeWhile((element) => element is String).cast<String>()) {
    yield msg;
  }

  // return Isolate.spawn(_getMessages, rp.sendPort)
  //     .asStream()
  //     .asyncExpand((_) => rp)
  //     .takeWhile((element) => element is String)
  //     .cast();
}

void _getMessages(SendPort sp) async {
  await for (var timeNow in Stream.periodic(
    const Duration(microseconds: 200),
    (_) => DateTime.now().toIso8601String(),
  )) {
    sp.send(timeNow);
  }
}
