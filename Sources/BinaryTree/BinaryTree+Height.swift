extension Tree where Children == BinaryChildren<Element> {
  public var height: Int {
    guard case let .node(value: _, children) = self else { return 0 }
    var sum = 0
    sum = sum + max(children.left.height, children.right.height) + 1
    return sum
  }
}

extension Tree where Children == BinaryChildren<Element>, Element: Equatable & Comparable {
  public func contains(_ i: Element) -> Bool {
    guard case let .node(value: value, children) = self else { return false }
    if i < value {
      return children.left.contains(i)
    }else if i > value {
      return children.right.contains(i)
    }else {
      return true
    }
  }
}
