part of 'gallery_cubit.dart';


@immutable
abstract class GalleryState extends Equatable{
  const GalleryState();

  @override
  List<Object> get props => [];
}

class GalleryInitial extends GalleryState{
  const GalleryInitial();
}

class GalleryLoading extends GalleryState{
  const GalleryLoading();
}

class GalleryLoaded extends GalleryState{
  final List<String> images;
  final List<String> names;
  const GalleryLoaded({required this.names, required this.images});

  @override
  List<Object> get props => [names, images];
}

class GalleryError extends GalleryState{
  final String message;
  const GalleryError({required this.message});

  @override
  List<Object> get props => [message];
}