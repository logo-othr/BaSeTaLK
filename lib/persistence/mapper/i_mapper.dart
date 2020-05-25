abstract class IMapper<T, V> {
  T map(V v);

  V revertMap(T t);
}
