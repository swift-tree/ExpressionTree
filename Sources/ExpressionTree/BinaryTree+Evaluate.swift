import BinaryTree

public extension BinaryTree where Descendent == BinaryChildren<Element>, Element == Token {
  var evaluate: Int? {
    switch self {
    case .empty:
      return nil

    case let .node(value: .num(value), _):
      return value

    case let .node(value: .funct(solve), children):
      guard let left = children.left.evaluate, let right = children.right.evaluate else { return nil }
      return solve.f(left, right)
    }
  }
}
