import 'package:science_hall/data/datasource/remote/remote_datasource.dart';
import 'package:science_hall/domain/entity/token_entity.dart';

abstract class ScienceRepository {
  RemoteDataSource dataSource;

  ScienceRepository(this.dataSource);

  Future<TokenEntity> getToken(Map<String, dynamic> param);
}