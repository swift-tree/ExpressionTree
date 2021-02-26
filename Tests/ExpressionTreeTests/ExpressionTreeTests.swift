import XCTest
import ExpressionTree
import BinaryTree

final class ExpressionTreeTests: XCTestCase {
  typealias ExpressionTree = BinaryTree<Token>
  
  func test_init() {
    let tree = ExpressionTree.node(value: .funct(.multiply), .init(.leaf(2), .leaf(3)))

    XCTAssertEqual(tree.evaluate, 2 * 3)
  }

  func test_init1() {
    let tree = ExpressionTree.node(value: .funct(.divide), .init(.leaf(6), .node(value: .funct(.multiply), .init(.leaf(2), .leaf(3)))))

    XCTAssertEqual(tree.evaluate, 1)
  }

  func test_init123() {
    let tree = ExpressionTree
      .node(value: .funct(.add), .init(.node(value: .funct(.multiply), .init(.leaf(2), .leaf(4))
      ), .node(value: .funct(.multiply), .init(.leaf(2), .leaf(3)))))

    XCTAssertEqual(tree.evaluate, 2*4+2*3)
  }

  func test_parser() {
    let tree = ExpressionTree.empty.parse(.node(value: .funct(.add), .init(.node(value: .num(2), .init(.node(value: .num(5), .noDescendent))))))

    XCTAssertEqual(tree.evaluate, 7)
  }

  func test_parser1() {
    let tree = ExpressionTree.empty.parse(
      .node(value: .funct(.add),
            .init(.node(value: .funct(.add),
                        .init(.node(value: .num(5),
                                    .init(.node(value: .num(2),
                                                .init(.node(value: .num(8), .noDescendent)))))))))
    )

    XCTAssertEqual(tree.evaluate, 20)
  }

  func test_init1234() {
    let tree = ExpressionTree(expression: "+ * 4 2 8")

    XCTAssertEqual(tree.evaluate, 1)
  }

  func test_init12345() {
    var a = 1
    let tree = BinaryTree<() -> Void>.node(value: {a = a * 3}, .init(.node(value: {a = a * 7}, .noDescendent), .node(value: {a = a * 5}, .noDescendent)))

    tree.traverse(method: .preOrder) { (void, paths) in
      void()
    }
    print(a)
  }

  static var allTests = [
    ("test_init", test_init),
  ]
}
