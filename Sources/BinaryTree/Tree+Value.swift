public extension Tree {
  var value: Element? {
    guard case let .node(value: value, _) = self else { return nil }
    return value
  }
}

