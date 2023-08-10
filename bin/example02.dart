import 'dart:isolate';

void main(List<String> args) async {}

const messagesAndResponses = {
  '': 'Ask me a question like "How are you?"',
  'Hello': 'Hi',
  'How are you?': 'Fine',
  'What are you doing?': 'Learning about Isolatesin Dart!',
  'Are you having fun?': 'Yeay sure!',
};

void _commuincator(SendPort sp) async {
  final rp = ReceivePort();
  sp.send(rp);
}
