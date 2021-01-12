public enum Tree<Element, Children: ChildrenProtocol> {
  case empty
  indirect case node(value: Element, Children)
}

extension Tree: Equatable where Element: Equatable, Children: Equatable {}
extension Tree: Hashable where Element: Hashable, Children: Hashable {}
