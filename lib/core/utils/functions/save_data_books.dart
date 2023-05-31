import 'package:hive/hive.dart';

import '../../../Features/home/domain/entites/book_entity.dart';

void saveBooksData(List<BookEntity> books, String boxName) {
  var box = Hive.box<BookEntity>(boxName);
  box.addAll(books);
}



