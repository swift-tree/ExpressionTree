extension Tree where Children == BinaryChildren<Element> {
  public var height: Int {
    guard case let .node(value: _, children) = self else { return 0 }
    var sum = 0
    sum = sum + max(children.left.height, children.right.height) + 1
    return sum
  }
}
