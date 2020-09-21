import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beer App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final client =
      Dio(BaseOptions(baseUrl: "https://jsonplaceholder.typicode.com"));

  bool isLoading = false;
  List<dynamic> brands;

  void fetch() async {
    setState(() {
      isLoading = true;
    });
    final response = await client.get("/photos");
    setState(() {
      brands = response.data;
      isLoading = false;
    });
  }

  @override
  void initState() {
    fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Center(child: Text("EM DESENVOLVIMENTO")),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFFff9051),
        centerTitle: false,
        title: Text(
          "Marcas",
          style: TextStyle(color: Colors.white),
        ),
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: brands.length,
              itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: AspectRatio(
                                aspectRatio: 3 / 4,
                                child: Image.network(
                                  brands[index]['url'],
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Expanded(
                              flex: 1,
                              child: Text(brands[index]['title']
                                  .toString()
                                  .split(" ")[0]))
                        ],
                      ),
                    ),
                  )),
    );
  }
}
