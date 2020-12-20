import Tree

public struct BinaryChildren<T>: ChildrenProtocol {
  public var left: BinaryTree<T>
  public var right: BinaryTree<T>

  public init(_ left: BinaryTree<T>, _ right: BinaryTree<T>) {
    self.left = left
    self.right = right
  }
}

public extension BinaryChildren { var height: Int { max(left.height, right.height) } }

extension BinaryChildren: Equatable where T: Equatable {}
extension BinaryChildren: Hashable where T: Hashable {}
