import '../datasources/users_remote_datasource.dart';
import '../models/user_model.dart';

class UsersRepositoryImpl {
  final UsersRemoteDatasource datasource;

  UsersRepositoryImpl(this.datasource);

  Future<UserModel> syncCurrentUser(String firebaseToken) async {
    final json = await datasource.upsertMe(firebaseToken: firebaseToken);
    return UserModel.fromJson(json);
  }

  Future<List<UserModel>> listUsers() {
    return datasource.getUsers();
  }
}