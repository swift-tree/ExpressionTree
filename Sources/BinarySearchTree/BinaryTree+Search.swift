import BinaryTree
import Tree

public extension BinaryTree where Children == BinaryChildren<Element>, Element: Comparable {
  func search(initialPath: LinkedList<Element> = .empty, _ i: Element) -> LinkedList<Element> {
    guard case let .node(value: value, children) = self else { return .empty }
    let path = initialPath.insert(value)
    if i < value {
      return children.left.search(initialPath:path, i)
    }else if i > value {
      return children.right.search(initialPath:path, i)
    }else {
      return path
    }
  }
}
