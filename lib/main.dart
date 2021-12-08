import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:q4_todo_flutter/add_task.dart';
import 'package:q4_todo_flutter/db_helper.dart';
import 'package:q4_todo_flutter/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late DbHelper helper;

  @override
  void initState() {
    setState(() {
      this.helper = DbHelper();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder(
          future: this.helper.getAllUser(),
          builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Icon(Icons.delete_forever),
                        ),
                        key: ValueKey<int>(snapshot.data![index].id),
                        onDismissed: (DismissDirection direction) async {
                          await this
                              .helper
                              .deleteUser(snapshot.data![index].id);
                          setState(() {
                            snapshot.data!.remove(snapshot.data![index]);
                          });
                        },
                        child: Card(
                          child: ListTile(
                            contentPadding: EdgeInsets.all(8.0),
                            title: Text(snapshot.data![index].name),
                            subtitle:
                                Text(snapshot.data![index].age.toString()),
                          ),
                        ));
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddUserPage()));
        },
        child: const Icon(Icons.add),
      ),
    ));
  }
}
