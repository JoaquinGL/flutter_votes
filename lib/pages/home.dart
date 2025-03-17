import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:votes/models/topic.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Topic> topics = [
    Topic(id: '1', name: 'AI', votes: 4),
    Topic(id: '2', name: 'Performance', votes: 5),
    Topic(id: '3', name: 'BBDD', votes: 2),
    Topic(id: '4', name: 'Pipelines', votes: 1),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Topics & pills',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        elevation: 1,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: topics.length,
        itemBuilder: (context, index) => _topicTile(topics[index]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewTopic,
        elevation: 1,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _topicTile(Topic topic) {
    return Dismissible(
      key: Key(topic.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        if (kDebugMode) {
          print('direction: $direction');
          print('topic id: ${topic.id}');
        }

        //TODO: call delete from server
      },
      background: Container(
        color: Colors.red,
        padding: EdgeInsets.only(left: 8.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text('Delete topic', style: TextStyle(color: Colors.white)),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Text(topic.name.substring(0, 2)),
        ),
        title: Text(topic.name),
        trailing: Text('${topic.votes}', style: TextStyle(fontSize: 20)),
        onTap: () {
          if (kDebugMode) {
            print(topic.name);
          }
        },
      ),
    );
  }

  void addNewTopic() {
    final textController = TextEditingController();

    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: const Text('New topic name'),
            content: CupertinoTextField(
              controller: textController,
              placeholder: 'Enter topic name',
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () => addTopicToList(textController.text),
                child: const Text('Add'),
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                onPressed: _close,
                child: const Text('Dismiss'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('New topic name'),
            content: TextField(
              controller: textController,
              decoration: const InputDecoration(hintText: 'Enter topic name'),
            ),
            actions: [
              MaterialButton(
                color: Colors.blue,
                elevation: 5,
                onPressed: () => addTopicToList(textController.text),
                child: const Text('Add', style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        },
      );
    }
  }

  addTopicToList(String name) {
    if (kDebugMode) {
      print(name);
    }

    if (name.length > 1) {
      topics.add(Topic(id: DateTime.now().toString(), name: name, votes: 0));
      setState(() {});
    }

    Navigator.of(context).pop();
  }

  _close() {
    Navigator.pop(context);
  }
}
