import 'package:flutter/widgets.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';
import 'package:movie_app/data/vos/credit_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';

class MovieDetailsBloc extends ChangeNotifier{


  MovieVO? mMovie;
  late List<CreditVO> mActorList;
  late List<CreditVO> mCreatorsList;

  /// Model
  MovieModel mMovieModel = MovieModelImpl();

  MovieDetailsBloc(int movieId) {
    /// MovieDetail
  mMovieModel.getMovieDetails(movieId)?.then((movie) {
    this.mMovie = movie;
    notifyListeners();
  });

  mMovieModel.getMovieDetailsFromDatabase(movieId)?.then((movie) {
    this.mMovie = movie;
    notifyListeners();
  });


  /// Credit
  mMovieModel.getCreditsByMovie(movieId)?.then((creditList) {
    mActorList = creditList.where((credit) => credit.isActor()).toList();
    mCreatorsList = creditList.where((credit) => credit.isCreator()).toList();
    notifyListeners();
  });


  }


}