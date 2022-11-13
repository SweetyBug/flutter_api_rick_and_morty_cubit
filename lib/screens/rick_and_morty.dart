import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and/bloc/gallery_cubit.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rick and Morty"),
        centerTitle: true,
      ),
      body: BlocBuilder<GalleryCubit, GalleryState>(
        builder: (context, state) {
          if (state is GalleryLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white,),);
          }
          if (state is GalleryLoaded) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                    itemCount: state.images.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 6.0,
                      mainAxisSpacing: 6.0,
                    ),
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [
                            Expanded(
                              child: Image.network(state.images[index], fit: BoxFit.cover,),
                            ),
                            Text(state.names[index]),
                          ],
                        ),
                      );
                    }),
              ),
            );
          }
          if (state is GalleryError) {
            return Center(
              child: Container(
                color: Colors.red,
                child: const Text("ERROR... Sorry",
                  style: TextStyle(fontSize: 30, color: Colors.black),
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
