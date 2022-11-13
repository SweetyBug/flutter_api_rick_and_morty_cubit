import 'package:flutter/material.dart';
import '../services/network_helper.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<Map<String, String>>? images;

  Future<Map<String, String>> getImages() async {
    Map<String, String> images = {};
    String url = "https://rickandmortyapi.com/api/character";
    NetworkHelper networkHelper = NetworkHelper(url: url);

    dynamic data = await networkHelper.getData();
    List<dynamic> results = data["results"] as List;

    for (int i = 0; i < results.length; i++) {
      images[results[i]["name"]] = results[i]["image"];
    }
    return images;
  }

  @override
  void initState() {
    super.initState();
    images = getImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rick and Morty APP"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: images,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          Map? content = snapshot.data ?? {};
          List entries = content!.entries.toList();
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              ));
            case ConnectionState.done:
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GridView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 6,
                        mainAxisSpacing: 6,
                      ),
                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(
                            children: [
                              Expanded(
                                child: Image.network(
                                  entries.elementAt(index).value,
                                ),
                              ),
                              Text("${entries.elementAt(index).key}"),
                            ],
                          ),
                        );
                      }),
                ),
              );
          }
        },
      ),
    );
  }
}
