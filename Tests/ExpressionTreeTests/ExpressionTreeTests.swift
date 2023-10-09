import BinaryTree
import ExpressionTree
import XCTest

final class ExpressionTreeTests: XCTestCase {
  func test_evaluate_one_degree() {
    let tree = ExpressionTree.node(value: .funct(.multiply), .init(.leaf(2), .leaf(3)))

    XCTAssertEqual(tree.evaluate, 2 * 3)
  }

  func test_evaluate_two_degrees() {
    let tree = ExpressionTree.node(value: .funct(.divide), .init(.leaf(6), .node(value: .funct(.multiply), .init(.leaf(2), .leaf(3)))))

    XCTAssertEqual(tree.evaluate, 1)
  }

  func test_evaluate_init123() {
    let tree = ExpressionTree
      .node(value: .funct(.add), .init(.node(
        value: .funct(.multiply),
        .init(.leaf(2), .leaf(4))
      ), .node(value: .funct(.multiply), .init(.leaf(2), .leaf(3)))))

    XCTAssertEqual(tree.evaluate, 2 * 4 + 2 * 3)
  }
  
  func test_evaluate_init1234() {
    let tree = ExpressionTree
      .node(value: .funct(.add), .init(.node(
        value: .funct(.exponential),
        .init(.leaf(2), .leaf(4))
      ), .node(value: .funct(.multiply), .init(.leaf(2), .leaf(3)))))

    XCTAssertEqual(tree.evaluate, Int(pow(Double(2), 4)) + 2 * 3)
  }

  func test_parser_one_degree() {
    let actual = ExpressionTree.node(value: .funct(.add), .init(.leaf(.num(2)), .leaf(.num(5))))
    let expected = ExpressionTree.parse(.node(value: .funct(.add), .init(.node(value: .num(2), .init(.node(value: .num(5), .noDescendent))))))

    XCTAssertEqual(actual, expected)
  }

  func test_parser2() {
    let tree = ExpressionTree.parse(.node(value: .funct(.add), .init(.node(value: .num(2), .init(.node(value: .num(5), .noDescendent))))))

    XCTAssertEqual(tree.evaluate, 2 + 5)
  }

  func test_parser1() {
    let tree = ExpressionTree.parse([.funct(.add), .funct(.add), .num(5), .num(2), .num(8)])

    XCTAssertEqual(tree.evaluate, 5 + 2 + 8)
  }

  func test_evaluate_postfix() {
    let tree = ExpressionTree("+ * 4 2 2323")

    XCTAssertEqual(tree, .parse([.funct(.add), .funct(.multiply), .num(4), .num(2), .num(2_323)]))
    XCTAssertEqual(tree, .node(value: .funct(.add), .init(.node(value: .funct(.multiply), .init(.leaf(4), .leaf(2))), .leaf(.num(2_323)))))
    XCTAssertEqual(tree.evaluate, 2_331)
  }

  func test_evaluate() {
    let tree = ExpressionTree("* * * * * * * * 1 2 3 4 5 6 7 8 9")

    XCTAssertEqual(tree.evaluate, 1 * 2 * 3 * 4 * 5 * 6 * 7 * 8 * 9)
  }

  func test_evaluate1() {
    let tree = ExpressionTree("* * * * * * * 3 4 5 60 7 8 9 * 1 2")

    XCTAssertEqual(tree.evaluate, 1 * 2 * 3 * 4 * 5 * 60 * 7 * 8 * 9)
    
    var output = [Token]()
    tree.traverse(method: .inOrder) { token, _ in
      output.append(token)
    }
    
    XCTAssertEqual(
      output.map(\.debugDescription),
      ["3", "*", "4", "*", "5", "*", "60", "*", "7", "*", "8", "*", "9", "*", "1", "*", "2"]
    )
  }
  
  func test_evaluate2() {
    let tree = ExpressionTree("* ^ 2 3 ^ 3 2")

    XCTAssertEqual(tree.evaluate, 9 * 8)
  }

  func test_evaluate_postfix1() {
    let tree = ExpressionTree.parse([.funct(.add), .funct(.multiply), .num(4), .num(2), .num(2_323)])

    XCTAssertEqual(tree, .node(value: .funct(.add), .init(.node(value: .funct(.multiply), .init(.leaf(4), .leaf(2))), .leaf(.num(2_323)))))
  }

  static var allTests = [
    ("test_evaluate_one_degree", test_evaluate_one_degree),
    ("test_evaluate_postfix1", test_evaluate_postfix1),
    ("test_evaluate2", test_evaluate2),
    ("test_evaluate1", test_evaluate1),
    ("test_evaluate", test_evaluate),
    ("test_evaluate_postfix", test_evaluate_postfix),
    ("test_parser1", test_parser1),
    ("test_parser2", test_parser2),
    ("test_parser_one_degree", test_parser_one_degree),
    ("test_evaluate_init1234", test_evaluate_init1234),
    ("test_evaluate_two_degrees", test_evaluate_two_degrees),
  ]
}

