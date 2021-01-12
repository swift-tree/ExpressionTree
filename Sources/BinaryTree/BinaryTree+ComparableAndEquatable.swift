extension Tree where Children == BinaryChildren<Element>, Element: Equatable & Comparable {
  public mutating func insert(_ i: Element) {
    self = inserting(i)
  }

  public mutating func remove(treeUnder i: Element) {
    self = removing(treeUnder: i)
  }

  public func removing(treeUnder i: Element) -> Self {
    switch self {
    case .empty:
      return self
    case .node(value: i, _):
      return .empty
    case .node(value: let value, let children) where i < value:
      return .node(value: value, .init(children.left.removing(treeUnder: i), children.right))
    case .node(value: let value, let children): 
      return .node(value: value, .init(children.left, children.right.removing(treeUnder: i)))
    }
  }
  
  public func inserting(_ i: Element) -> Self {
    switch self {
    case .node(value: i, _):
      return self
    case let .node(value: value, children) where i < value:
      return .node(value: value, .init(children.left.inserting(i), children.right))
    case let .node(value: value, children):
      return .node(value: value, .init(children.left, children.right.inserting(i)))
    case .empty:
      return .node(value: i, .init(.empty, .empty))
    }
  }
}
