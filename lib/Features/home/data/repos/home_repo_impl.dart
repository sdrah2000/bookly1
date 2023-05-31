import 'package:bookly/Features/home/data/data_sources/home_local_data_source.dart';
import 'package:bookly/Features/home/data/data_sources/home_remote_data_source.dart';
import 'package:bookly/Features/home/domain/entites/book_entity.dart';

import 'package:bookly/core/errors/failure.dart';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/repos/home_rep.dart';

class HomeRepoImple extends HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;
  final HomeLocaleDataSource homeLocaleDataSource;

  HomeRepoImple(
      {required this.homeRemoteDataSource, required this.homeLocaleDataSource});
  @override
  Future<Either<Failure, List<BookEntity>>> fetchFeaturedBooks(
      {int pageNumber = 0}) async {
    try {
      var booksList =
          homeLocaleDataSource.fetchFeaturedBooks(pageNumber: pageNumber);
      if (booksList.isNotEmpty) {
        return right(booksList);
      }
      var books =
          await homeRemoteDataSource.fetchFeaturedBooks(pageNumber: pageNumber);
      print(books);
      return right(books);
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BookEntity>>> fetchNewestBooks() async {
    try {
      var booksList = homeLocaleDataSource.fetchNewestBooks();
      if (booksList.isNotEmpty) {
        return right(booksList);
      }
      var books = await homeRemoteDataSource.fetchNewestBooks();
      return right(books);
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
