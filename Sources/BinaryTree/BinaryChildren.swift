public struct BinaryChildren<T> {
  public let left: BinaryTree<T>
  public let right: BinaryTree<T>
}

extension BinaryChildren: Equatable where T: Equatable {}
extension BinaryChildren: Hashable where T: Hashable {}
