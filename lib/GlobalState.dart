class GlobalState {
  static Map<String, bool> _bools = Map<String, bool>();

  static GlobalState instance = GlobalState._();
  GlobalState._();

  get(key) => _bools[key];
  set(key, value) => _bools[key] = value;

  int counter() {
    int count = 0;
    _bools.forEach((k, v) {
      if (v == true) {
        count++;
      }
    });
    return count;
  }
}
