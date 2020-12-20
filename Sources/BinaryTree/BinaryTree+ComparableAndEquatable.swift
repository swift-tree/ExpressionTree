import Tree

public extension Tree where Children == BinaryChildren<Element>, Element: Equatable & Comparable {
  init(_ elements: [Element]) {
    var tree: BinaryTree<Element> = .empty
    elements.forEach{tree.insert($0)}
    self = tree
  }
  
  mutating func insert(_ i: Element) { self = inserting(i) }
  
  mutating func remove(_ i: Element) { self = removing(i) }
  
  func removing(_ i: Element) -> Self {
    switch self {
    case .empty: return self
    case .node(value: i, let children):
      switch (children.left, children.right) {
      case (.empty, .empty): return .empty
      case  (.node, .node):
        guard let inOrderSuccessor = children.right.min,
          let val = inOrderSuccessor.value,
          let right = inOrderSuccessor.children?.right else {
            return children.right
        }
        return .node(value: val, .init(children.left, right))
      case (_, .empty): return children.left
      case (.empty, _): return children.right
      }
    case let .node(value: value, children) where i < value:
      return .node(value: value, .init(children.left.removing(i), children.right))
    case let .node(value: value, children):
      return .node(value: value, .init(children.left, children.right.removing(i)))
    }
  }
  
  mutating func remove(treeUnder i: Element) { self = removing(treeUnder: i) }
  
  func removing(treeUnder i: Element) -> Self {
    switch self {
    case .empty:  return self
    case .node(value: i, _): return .empty
    case let .node(value: value, children) where i < value:
      return .node(value: value, .init(children.left.removing(treeUnder: i), children.right))
    case let .node(value: value, children):
      return .node(value: value, .init(children.left, children.right.removing(treeUnder: i)))
    }
  }
  
  func inserting(_ i: Element) -> Self {
    switch self {
    case .node(value: i, _): return self
    case let .node(value: value, children) where i < value:
      return .node(value: value, .init(children.left.inserting(i), children.right))
    case let .node(value: value, children):
      return .node(value: value, .init(children.left, children.right.inserting(i)))
    case .empty: return .node(value: i, .init(.empty, .empty))
    }
  }
}
