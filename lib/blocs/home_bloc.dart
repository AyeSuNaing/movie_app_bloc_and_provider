import 'package:flutter/cupertino.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';

class HomeBloc extends ChangeNotifier {

  /// States

  late List<MovieVO> mNowPlayingMovieList;
  late List<MovieVO> mPopularMovieList;
  late List<GenreVO> mGenreList;
  late List<ActorVO> mActors;
  late List<MovieVO> mShowCaseMovieList;
  late List<MovieVO> mMoviesByGenreList;


  ///Model
  MovieModel mMovieModel = MovieModelImpl();

  HomeBloc () {
    /// Now PLaying Movies Database
    mMovieModel.getNowPlayingMoviesFromDatabase()?.then((movieList) {
      mNowPlayingMovieList = movieList;
      notifyListeners();
    }).catchError((error){});

    /// Popular Movies Database
    mMovieModel.getPopularMoviesFromDatabase()?.then((movieList) {
      mPopularMovieList = movieList;
      notifyListeners();
    }).catchError((error){});

    /// Genres
    mMovieModel.getGenres()?.then((genreList) {
      mGenreList = genreList;
      notifyListeners();
      /// Movies By Genre
      getMoviesByGenreAndRefresh(genreList.first.id ?? 0);
    }).catchError((error){});

    /// Genres Database
    mMovieModel.getGenresFromDatabase()?.then((genreList) {
      mGenreList = genreList;
      notifyListeners();
      /// Movies By Genre
      getMoviesByGenreAndRefresh(genreList.first.id ?? 0);

    }).catchError((error){});

    /// Showcase Database
    mMovieModel.getTopRatedMoviesFromDatabase()?.then((movieList) {
      mShowCaseMovieList = movieList;
      notifyListeners();
    }).catchError((error) {});

    /// Actors
    mMovieModel.getActors(1)?.then((actorList) {
      mActors = actorList;
      notifyListeners();
    }).catchError((error){});

    /// Actors Database
    mMovieModel.getActorsFromDatabase()?.then((actorList) {
      mActors = actorList;
      notifyListeners();
    }).catchError((error){});

  }



  void onTapGenre(int genreId){
    getMoviesByGenreAndRefresh(genreId);
  }

  void getMoviesByGenreAndRefresh(int genreId){
    mMovieModel.getMoviesByGenre(genreId)?.then((moviesByGenre) {
      mMoviesByGenreList = moviesByGenre;
      notifyListeners();
    }).catchError((error){});
  }
  //
  // void dispose() {
  //   mNowPlayingStreamController.close();
  //   mPopularMoviesListStreamController.close();
  //   mGenreListStreamController.close();
  //   mActorsStreamController.close();
  //   mShowCaseMoviesListStreamController.close();
  //   mMoviesByGenreListStreamController.close();
  // }




}