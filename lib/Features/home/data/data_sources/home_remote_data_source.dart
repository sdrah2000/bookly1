import 'package:bookly/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly/constants.dart';
import 'package:bookly/core/utils/api_service.dart';
import 'package:hive/hive.dart';

import '../../../../core/utils/functions/save_data_books.dart';
import '../../domain/entites/book_entity.dart';

abstract class HomeRemoteDataSource {
  Future<List<BookEntity>> fetchFeaturedBooks({int pageNumber = 0});
  Future<List<BookEntity>> fetchNewestBooks();
}

class HomeRemoteDataSourceImplementaion extends HomeRemoteDataSource {
  final ApiService apiService;

  HomeRemoteDataSourceImplementaion(this.apiService);
  @override
  Future<List<BookEntity>> fetchFeaturedBooks({int pageNumber = 0}) async {
    var data = await apiService.get(
        endPoint: 'volumes?Filtering=free-ebooks&q=programming&startIndex=40');
    print(data);
    List<BookEntity> books = getBooksList(data);
    saveBooksData(books, KFeautredBox);
    return books;
  }

  @override
  Future<List<BookEntity>> fetchNewestBooks() async {
    var data = await apiService.get(
        endPoint: 'volumes?Filtering=free-ebooks&Sorting=newest&q=programming');
    List<BookEntity> books = getBooksList(data);
    saveBooksData(books, KNewestBox);

    return books;
  }

  List<BookEntity> getBooksList(Map<String, dynamic> data) {
    List<BookEntity> books = [];
    for (var bookMap in data['items']) {
      books.add(BookModel.fromJson(bookMap));
    }
    return books;
  }
}
