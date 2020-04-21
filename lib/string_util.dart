extension MyString on String {
  String cappitalize() {
    return this[0].toUpperCase() + this.substring(1);
  }
}

mixin UserUtils {
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}
