import 'package:flutter/material.dart';
import '../services/network_helper.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<List<String>>? images;

  Future<List<String>> getImages() async {
    List<String> images = [];

    String url = "https://rickandmortyapi.com/api/character";
    NetworkHelper networkHelper = NetworkHelper(url: url);
    dynamic data = await networkHelper.getData();
    List<dynamic> results = data["results"] as List;
    for (int i = 0; i < results.length; i++) {
      images.add(results[i]["image"]);
    }
    return images;
  }

  @override
  void initState() {
    images = getImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rick and Morty"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: images,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              case ConnectionState.done:
                return GridView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 6,
                    ),
                    itemBuilder: (context, index) {
                      return Image.network(snapshot.data![index]);
                    });
          }

          },
        ),
      ),
    );
  }
}
