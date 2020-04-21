import 'models/user.dart';

class UserHolder {
  Map<String, User> users = {};

  void registerUser(String name, String phone, String email) {
    User user = User(name: name, phone: phone, email: email);

    if (!users.containsKey(user.login))
      users.addAll({user.login: user});
    else
      throw Exception('A user with this name already exists');
  }

  User getUserByLogin(String login) {
    if (users.containsKey(login)) return users[login];
    throw Exception("User not found");
  }

  User registerUserByPhone(String fullName, String rawPhone) {
    final user = User.withPhone(fullName, rawPhone);

    if (!users.containsKey(user.login))
      return users[user.login] = user;
    else
      throw Exception('A user with this phone already exists');
  }

  User registerUserByEmail(String fullName, String email) {
    final user = User.withEmail(fullName, email);

    if (!users.containsKey(user.login))
      return users[user.login] = user;
    else
      throw Exception('A user with this email already exists');
  }

  void setFriends(String userLogin, List<User> newFriends) {
    users[userLogin].addFriends(newFriends);
  }

  User findUserInFriends(String login, User user) {
    final foundOutUser = users[login].friends.firstWhere((friend) => user == friend, orElse: () => null);

    if (foundOutUser != null) return foundOutUser;
    throw Exception('${user.login} is not a friend of the login');
  }

  List<User> importUsers(List<String> list) {
    list.forEach((string) {
      List<String> userFields = string.split(";");

      final newUser = User(
        name: userFields[0].trim(),
        email: userFields[1].trim(),
        phone: userFields[2].trim(),
      );

      users[newUser.login] = newUser;
    });

    return users.values.toList();
  }
}
