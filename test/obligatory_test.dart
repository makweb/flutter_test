import 'package:flutter_test/flutter_test.dart' show Skip, expect, group, isA, setUp, tearDownAll, test, throwsA;

import '../lib/user_holder.dart';
import '../lib/string_util.dart';
import '../lib/models/user.dart';

void main() {
  UserHolder holder;

  setUp(() {
    holder = UserHolder();
  });

  tearDownAll(() {
    holder = null;
  });

  test('module2', () {
    User user = holder.registerUserByPhone("John Ray", "+9-733 524-0185");

    expect(user.login, holder.getUserByLogin(user.login).login);
    expect(user.phone, holder.getUserByLogin(user.login).phone);
    expect(user.name, holder.getUserByLogin(user.login).name);
    expect(user.email, holder.getUserByLogin(user.login).email);

    holder.users.clear();

    expect(() => holder.registerUserByPhone("John Ray", "+9-733 524-085"), throwsA(isA<Exception>()));

    holder.users.clear();

    expect(() => holder.registerUserByPhone("John Ray", "+9-733 524-085"), throwsA(isA<Exception>()));
  });

  test('module1', () {
    User user = holder.registerUserByEmail("John Ray", "ray1550@yahoo.net");

    expect(user.login, holder.getUserByLogin(user.login).login);
    expect(user.phone, holder.getUserByLogin(user.login).phone);
    expect(user.name, holder.getUserByLogin(user.login).name);
    expect(user.email, holder.getUserByLogin(user.login).email);

    holder.users.clear();

    expect(() => holder.registerUserByEmail("John Ray", "dfdsag"), throwsA(isA<Exception>()));

    holder.registerUserByEmail("John Ray", "ray1550@yahoo.net");

    expect(() => holder.registerUserByEmail("John Ray", "ray1550@yahoo.net"), throwsA(isA<Exception>()));
  });

  test('module3', () {
    User user = User(name: "Dan Tot", phone: "+15750761449", email: "dan.tot@yandex.ru");
    holder.users[user.login] = user;

    List<User> friends = [
      User(name: "Ray Dalio", email: "ray.dalio@gmail.com"),
      User(name: "Warren Buffett", phone: "+1 833-914-92-65"),
    ];

    holder.setFriends(user.login, friends);

    expect(friends[0], holder.findUserInFriends(user.login, friends[0]));
    expect(friends[1], holder.findUserInFriends(user.login, friends[1]));

    user = null;
    friends = null;
    holder.users.clear();

    user = User(name: "Dan Tot", phone: "+15750761449", email: "dan.tot@yandex.ru");
    holder.users[user.login] = user;

    friends = [
      User(name: "Ray Dalio", email: "ray.dalio@gmail.com"),
      User(name: "Warren Buffett", phone: "+1 833-914-92-65"),
    ];

    expect(() => holder.findUserInFriends(user.login, friends[0]), throwsA(isA<Exception>()));
    expect(() => holder.findUserInFriends(user.login, friends[1]), throwsA(isA<Exception>()));
  });

  test('module4', () {
    expect(A().skill, 'Skill');
    expect(A().branch, 'Branch');
  });
}

class A with UserUtils {
  String get skill => capitalize("sKiLL");
  String get branch => capitalize("bRaNcH");
}
