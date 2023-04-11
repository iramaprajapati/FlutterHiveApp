import 'package:flutter/material.dart';
import 'package:flutter_hive_app/person.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'boxes.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PersonAdapter());
  boxPersons = await Hive.openBox<Person>('personBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Hive',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("My Hive App"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Image.network(
            "https://avatars.githubusercontent.com/u/55202745?s=200&v=4",
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Name",
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: ageController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Age",
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          boxPersons.put(
                            "key_${nameController.text}",
                            Person(
                              name: nameController.text,
                              age: int.parse(ageController.text),
                            ),
                          );
                        });
                      },
                      child: const Text(
                        "Add",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.builder(
                    itemCount: boxPersons.length,
                    itemBuilder: (context, index) {
                      Person person = boxPersons.getAt(index);
                      return ListTile(
                        leading: IconButton(
                          onPressed: () {
                            setState(() {
                              boxPersons.deleteAt(index);
                            });
                          },
                          icon: const Icon(Icons.delete),
                        ),
                        title: Text(person.name),
                        trailing: Text("Age : ${person.age.toString()}"),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          TextButton.icon(
            onPressed: () {
              setState(() {
                boxPersons.clear();
              });
            },
            icon: const Icon(
              Icons.delete_outlined,
            ),
            label: const Text(
              "Delete All",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
