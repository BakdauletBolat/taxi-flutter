import 'package:mobx/mobx.dart';

// Include generated file
part 'user-store.g.dart';

// This is the class used by rest of your codebase
class UserStore = UserBase with _$UserStore;

// The store-class
abstract class UserBase with Store {
  @observable
  bool isAuth = true;

  void changeIsAuth() {
    runInAction(() => {isAuth = true});
  }

  void logout() {
    runInAction(() => {isAuth = false});
  }
}
