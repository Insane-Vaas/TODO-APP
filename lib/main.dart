import 'package:flutter/material.dart';
import 'package:todoapp/text.dart';

void main() => runApp(const TODOAPP());

class TODOAPP extends StatelessWidget {
  const TODOAPP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? tTitle;
  String? tText;
  var list = <Texts>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TODO"),
        backgroundColor: Colors.red.shade400,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 10, 50, 0),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                    hintText: "Enter Title",
                  ),
                  onChanged: (value) => setState(
                    () {
                      if (value.isNotEmpty) {
                        tTitle = value;
                      } else {
                        tTitle = null;
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                    hintText: "Enter Text",
                  ),
                  onChanged: (value) => setState(
                    () {
                      if (value.isNotEmpty) {
                        tText = value;
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        setState(
                          () {
                            if (tTitle != null) {
                              Texts newTodo = Texts(tTitle, tText);
                              list.add(newTodo);
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) => dialogMarna(context),
                              );
                            }
                          },
                        );
                      },
                      child: const Text("Add"),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (context, index) => showAllTODOs(context, index, list),
          ),
        ],
      ),
    );
  }
}

//Dialog will appear when title is empty.
dialogMarna(context) {
  return AlertDialog(
    title: const Text("Error"),
    content: const Text("Title Can not empty"),
    actions: <Widget>[
      ElevatedButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: const Text("Okay"))
    ],
  );
}

//Showing data here
showAllTODOs(context, index, List<Texts> list) {
  Texts? tsee;
  if (list.isNotEmpty) {
    tsee = list[index];
  }
  String? tti = tsee?.getTitle();
  String? tte = tsee?.getText();
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: ListTile(
        title: Text(
          "$tte",
          maxLines: 10,
          style: const TextStyle(
            color: Colors.blueAccent,
          ),
          textAlign: TextAlign.end,
        ),
        leading: Text(
          "$tti",
          style: const TextStyle(
            color: Colors.redAccent,
          ),
        ),
        hoverColor: Colors.blue,
        onLongPress: () => {
          list.remove(tsee),
        },
      ),
    ),
  );
}
