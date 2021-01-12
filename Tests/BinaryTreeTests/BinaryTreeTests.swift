import XCTest
import BinaryTree

final class BinaryTreeTests: XCTestCase {
  var tree: Tree<Int, BinaryChildren<Int>>!
  var initialItems: [Int]!
  var capturedItems: [Int]!
  
  override func setUp() {
    super.setUp()
    
    self.tree = .empty
    self.initialItems = [5,10,15,6]
    self.capturedItems = []
  }
  
  override func tearDown() {
    tree = nil
    initialItems = nil
    capturedItems = nil
    
    super.tearDown()
  }
  
  func test_traversals_preOrder() {
    initialItems.forEach{tree.inserting($0)}
    
    tree.traverse(method: .preOrder) { [weak self] value, _ in
      self?.capturedItems.append(value)
    }
    
    XCTAssertEqual(capturedItems, [5,10,6,15])
  }
  
  func test_traversals_inOrder() {
    initialItems.forEach{tree.inserting($0)}

    tree.traverse(method: .inOrder) { [weak self] value, _ in
      self?.capturedItems.append(value)
    }

    XCTAssertEqual(capturedItems, [5,6,10,15])
  }

  func test_traversals_postOrder() {
    initialItems.forEach{tree.inserting($0)}

    tree.traverse(method: .postOrder) { [weak self] value, _ in
      self?.capturedItems.append(value)
    }

    XCTAssertEqual(capturedItems, [6,15,10,5])
  }

  func test_height(){
    tree.inserting(initialItems.removeFirst())

    XCTAssertEqual(tree.height, 1)

    tree.inserting(initialItems.removeFirst())

    XCTAssertEqual(tree.height, 2)

    tree.inserting(initialItems.removeFirst())

    XCTAssertEqual(tree.height, 3)

    tree.inserting(initialItems.removeFirst())

    XCTAssertEqual(tree.height, 3)
  }

  func test_string_preOrder(){
    var paths = [String]()
    var tree: Tree<String, BinaryChildren<String>> = .empty
    tree.inserting("abc")
    tree.inserting("bca")
    tree.inserting("acb")
    tree.inserting("ab")
    tree.inserting("ca")

    tree.traverse(method: .preOrder) { _, path in
      paths.append(path.joined(separator: "/"))
    }

    XCTAssertEqual(tree.height, 3)

    XCTAssertEqual(
      paths,
      [
        "abc",
        "abc/ab",
        "abc/bca",
        "abc/bca/acb",
        "abc/bca/ca",
      ]
    )
  }

  static var allTests = [
    ("test_traversals_preOrder", test_traversals_preOrder),
    ("test_traversals_inOrder", test_traversals_inOrder),
    ("test_traversals_postOrder", test_traversals_postOrder),
    ("test_height", test_height),
  ]
}
