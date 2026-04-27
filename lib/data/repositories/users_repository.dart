import '../datasources/users_remote_datasource.dart';
import '../models/user_model.dart';

class UsersRepository {
  final UsersRemoteDatasource datasource;

  UsersRepository(this.datasource);

  Future<List<UserModel>> getUsers() {
    return datasource.getUsers();
  }
}