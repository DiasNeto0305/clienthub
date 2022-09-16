extension ExtensionString on String {
  String toFirstCharToUpperCase() {
    // ignore: unnecessary_this
    return this[0].toUpperCase() + this.substring(1);
  }
}