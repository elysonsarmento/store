class DependencyInjector {
  static final Map<String, dynamic> _dependencies = {};

  static void register<T>(T instance, {String name = ''}) {
    String key = name.isNotEmpty ? name : T.toString();
    _dependencies[key] = instance;
  }

  static T get<T>({String name = ''}) {
    String key = name.isNotEmpty ? name : T.toString();
    if (_dependencies.containsKey(key)) {
      return _dependencies[key] as T;
    } else {
      throw Exception("Dependency $key not found.");
    }
  }
}
