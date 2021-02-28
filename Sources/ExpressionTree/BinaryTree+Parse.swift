import BinaryTree
import Tree

extension ExpressionTree where Descendent == BinaryChildren<Element> {
  public static func parse(_ prefixTokens: LinkedList<Token>) -> Self {
    _parse(prefixTokens).tree
  }

  private static func _parse(_ prefixTokens: LinkedList<Token>) -> (tree: Self, prefixTokens: LinkedList<Token>) {
    switch prefixTokens {
    case .empty:
      return (.empty, .empty)

    case let .node(value: .num(num), _):
      return (.leaf(.num(num)), prefixTokens.next)

    case let .node(value: value, _):
      let left = Self._parse(prefixTokens.next)
      let right = Self._parse(left.prefixTokens)
      return (tree: .node(value: value, .init(left.tree, right.tree)), prefixTokens: right.prefixTokens)
    }
  }

  public init(prefixExpression: String) {
    self = Self
      .parse(LinkedList(
        prefixExpression
          .split(separator: " ")
          .compactMap {
            Token(String($0))
          }
      )
      )
  }
}
