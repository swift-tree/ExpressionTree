public struct BinaryChildren<T> {
  public init(left: BinaryTree<T>, right: BinaryTree<T>) {
    self.left = left
    self.right = right
  }

  public let left: BinaryTree<T>
  public let right: BinaryTree<T>
}

extension BinaryChildren: Equatable where T: Equatable {}
extension BinaryChildren: Hashable where T: Hashable {}
