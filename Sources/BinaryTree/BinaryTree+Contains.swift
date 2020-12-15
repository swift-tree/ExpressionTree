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

  public func search(initialPath: [Element] = [], _ i: Element) -> [Element] {
     guard case let .node(value: value, children) = self else { return [] }
     let path = initialPath + [value]
     if i < value {
      return children.left.search(initialPath:path, i)
     }else if i > value {
      return children.right.search(initialPath:path, i)
     }else {
       return path
     }
   }
}
