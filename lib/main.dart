import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and/bloc/gallery_cubit.dart';
import 'package:rick_and/screens/rick_and_morty.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GalleryCubit()..getCards(),
      child: MaterialApp(
        theme: ThemeData.dark(),
        home: const MyHomePage(),
      ),
    );
  }
}
