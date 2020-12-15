extension Tree where Children == BinaryChildren<Element>, Element: Equatable & Comparable {
  public mutating func inserting(_ i: Element) {
    self = insert(i)
  }
  
  public func insert(_ i: Element) -> Self {
    switch self {
    case let .node(value: value, children):
      if i < value {
        return .node(value: value, .init(left: children.left.insert(i), right: children.right))
      } else if i > value {
        return .node(value: value, .init(left: children.left, right: children.right.insert(i)))
      } else {
        return self
      }
    case .empty:
      return .node(value: i, .init(left: .empty, right: .empty))
    }
  }
}

