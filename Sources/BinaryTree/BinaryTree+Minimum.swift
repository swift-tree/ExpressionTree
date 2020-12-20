public extension Tree where Children == BinaryChildren<Element> {
  var min: Tree? {
    guard case let .node(value: _, children) = self else { return nil }
    return children.left.min ?? self
  }
}

