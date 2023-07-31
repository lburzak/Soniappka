extension MapTransform<K, V> on Map<K, V> {
  Map<K, V> withValueAt({required K key, required V value}) {
    final newMap = Map<K, V>.from(this);
    newMap[key] = value;
    return newMap;
  }
}

extension MapFromEntries<K, V> on Iterable<MapEntry<K, V>> {
  Map<K, V> collectToMap() => Map.fromEntries(this);
}
