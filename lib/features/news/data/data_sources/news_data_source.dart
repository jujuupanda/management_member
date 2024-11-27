import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/services/database_service.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../../../../core/shared/model/blank_model.dart';
import '../../domain/use_cases/create_news_use_case.dart';
import '../../domain/use_cases/delete_news_use_case.dart';
import '../../domain/use_cases/edit_news_use_case.dart';
import '../../domain/use_cases/get_news_use_case.dart';
import '../models/news_model.dart';

part 'news_remote_data_source.dart';

abstract class NewsDataSource {
  Future<Either<Failure, BlankModel>> createNews(CreateNewsParam params);

  Stream<Either<Failure, List<NewsModel>>> getNews(GetNewsParam params);

  Future<Either<Failure, BlankModel>> editNews(EditNewsParam params);

  Future<Either<Failure, BlankModel>> deleteNews(DeleteNewsParam params);
}
