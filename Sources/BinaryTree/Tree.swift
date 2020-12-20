public enum Tree<Element, Children: ChildrenProtocol> {
  case empty
  indirect case node(value: Element, Children)
}

public extension Tree {
  var children: Children? {
    guard case let .node(value: _, children) = self else { return nil }
    return children
  }
  
  var value: Element? {
    guard case let .node(value: value, _) = self else { return nil }
    return value
  }
}

extension Tree: Equatable where Element: Equatable, Children: Equatable {}
extension Tree: Hashable where Element: Hashable, Children: Hashable {}
