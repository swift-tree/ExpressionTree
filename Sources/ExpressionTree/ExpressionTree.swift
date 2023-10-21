import BinaryTree
import Tree
import Foundation

public typealias ExpressionTree = BinaryTree<Token>

public enum Token: CustomDebugStringConvertible {
  case num(Int)
  case funct(Operation)

  init?(_ str: String) {
    if let num = Int(str) {
      self = .num(num)
    } else if let op = Operation(Character(str)) {
      self = .funct(op)
    } else {
      return nil
    }
  }

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

extension Token {
  public enum Operation: CustomDebugStringConvertible {
    public typealias Func = (Int, Int) -> Int

    public var debugDescription: String {
      String(sign)
    }

    case multiply, divide, add, subtract, exponential
    var f: Func {
      switch self {
      case .add: return (+)
      case .divide: return (/)
      case .multiply: return (*)
      case .subtract: return (-)
      case .exponential: return { Int(pow(Double($0), Double($1))) }
      }
    }

    var sign: Character {
      switch self {
      case .add: return "+"
      case .divide: return "/"
      case .multiply: return "*"
      case .subtract: return "-"
      case .exponential: return "^"
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
      case "^":
        self = .exponential
      default:
        return nil
      }
    }
  }
}

extension Token: Hashable {}
extension Token.Operation: Codable {}
extension Token: Codable {}
