import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:rick_and/services/network_helper.dart';

part 'gallery_state.dart';

class GalleryCubit extends Cubit<GalleryState> {
  GalleryCubit() : super(const GalleryInitial());

  Future<void> getCards() async {
    emit(const GalleryLoading());
    List<String> images = [];
    List<String> names = [];
    String url = "https://rickandmortyapi.com/api/character";
    NetworkHelper networkHelper = NetworkHelper(url: url);
    dynamic data = await networkHelper.getData();
    List<dynamic> results = data["results"] as List;
    for(int i=0; i<results.length; i++) {
      images.add(results[i]["image"]);
      names.add(results[i]["name"]);
    }
    emit(GalleryLoaded(names: names, images: images));
  }

}