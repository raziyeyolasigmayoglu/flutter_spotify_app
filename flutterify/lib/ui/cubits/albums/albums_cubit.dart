import 'package:bloc/bloc.dart';
import 'package:flutterify/data/models/spotify_album.dart';
import 'package:flutterify/domain/api/models/spotify_api_response.dart';
import 'package:flutterify/domain/repositories/spotify_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'albums_state.dart';
part 'albums_cubit.freezed.dart';

// This is the Cubit that manages the state of the Albums screen
class AlbumsCubit extends Cubit<AlbumsState> {
  final ISpotifyRepository repository;

  AlbumsCubit({required this.repository}) : super(const AlbumsState.initial());

  Future<void> getAlbums(String query) async {
    emit(const AlbumsState.loading());
    try {
      final response = await repository.getAlbums(query);
      emit(AlbumsState.loaded(response));
    } catch (e) {
      emit(AlbumsState.error(e.toString()));
    }
  }
}
