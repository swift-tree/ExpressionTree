public extension Tree {
  var children: Children? {
    guard case let .node(value: _, children) = self else { return nil }
    return children
  }
}
