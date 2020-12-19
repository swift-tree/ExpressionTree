public struct BinaryChildren<T> {
  public init(_ left: BinaryTree<T>, _ right: BinaryTree<T>) {
    self.left = left
    self.right = right
  }

  public var left: BinaryTree<T>
  public var right: BinaryTree<T>
}

extension BinaryChildren: Equatable where T: Equatable {}
extension BinaryChildren: Hashable where T: Hashable {}
