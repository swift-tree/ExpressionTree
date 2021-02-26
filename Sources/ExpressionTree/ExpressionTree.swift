import BinaryTree
import Tree

public enum Token: CustomDebugStringConvertible {
  case num(Int)
  case funct(Op)

  public var debugDescription: String {
    switch self {
    case let .num(int):
      return String(int)
    case let .funct(op):
      return op.debugDescription
    }
  }
}

extension Token: ExpressibleByIntegerLiteral {
  public init(integerLiteral value: Int) {
    self = .num(value)
  }
}

public enum Op: CustomDebugStringConvertible {
  public typealias Func = (Int, Int) ->  Int

  public var debugDescription: String {
    String(sign)
  }

  case multiply, divide, add, subtract, custom(Func)
  var f: Func {
    switch self {
    case .multiply: return (*)
    case .divide: return (/)
    case .subtract: return (-)
    case .add: return (+)
    case let .custom(f): return f
    }
  }

  var sign: Character {
    switch self {
    case .multiply: return "*"
    case .divide: return "/"
    case .subtract: return "-"
    case .add: return "+"
    case .custom: return "C"
    }
  }

  init?(_ c: Character) {
    switch c {
    case "*":
      self = .multiply
    case "/":
      self = .divide
    case "-":
      self = .subtract
    case "+":
      self = .add
    default:
      return nil
    }
  }
}

public extension BinaryTree where Children == BinaryChildren<Element>, Element == Token {
  func parse(_ postfixTokens: LinkedList<Token>) -> Self {
    switch postfixTokens {
    case .empty:
      return .empty
    case let .node(value: .num(num), _):
      return .leaf(.num(num))
    case let .node(value: .funct(f), child):
      return .node(value: .funct(f), .init(parse(child.next), parse(child.next.next!)))
    }
  }

  func parse1(_ postfixTokens: LinkedList<Token>) -> Self {
    switch postfixTokens {
    case .empty:
      return .empty
    case let .node(value: .num(num), _):
      return .leaf(.num(num))
    case let .node(value: .funct(f), child):
      return .node(value: .funct(f), .init(parse1(child.next), parse1(child.next.next!)))
    }
  }

  init(expression: String) {
    self = .empty
  }
}

public extension BinaryTree where Children == BinaryChildren<Element>, Element == Token {
  var evaluate: Int {
    switch self {
    case .empty:
      return 0
    case .node(value: let .num(value), _):
      return value
    case let .node(value: .funct(solve), children):
      return solve.f(children.left.evaluate, children.right.evaluate)
    }
  }
}
