import XCTest
import BinarySearchTree
import BinaryTree

final class BinarySearchTreeTests: XCTestCase {
  typealias BinarySearchIntegerTree = BinaryTree<Int>
  
  var tree: BinarySearchIntegerTree!
  var capturedItems: [Int]!
  
  override func setUp() {
    super.setUp()
    
    tree = .init([5, 5, 10, 15, 6])
    capturedItems = []
  }
  
  override func tearDown() {
    tree = nil
    capturedItems = nil
    
    super.tearDown()
  }
  
  func test_init() {
    XCTAssertEqual(tree, tree5_10_6_15)
  }
  
  func test_min_no_left_tree() {
    let tree = BinarySearchIntegerTree([6, 7, 8 ,9 ,10])
    
    XCTAssertEqual(tree.min, tree)
  }

  func test_min_no_right_tree() {
    let tree = BinarySearchIntegerTree([6, 7, 8 ,9 ,10].reversed())
    
    XCTAssertEqual(tree.min, .node(value: 6, .noDescendent))
  }
  
  func test_min_right_tree() {
    XCTAssertEqual(tree.children?.right.min, .node(value: 6, .noDescendent))
  }
  
  func test_remove_root_1_level() {
    var tree = BinarySearchIntegerTree([1])
    tree.remove(1)
    
    XCTAssertEqual(tree, .empty)
  }
  
  func test_remove_one_childed() {
    var actual = BinarySearchIntegerTree([16, 5, 10, 15, 6])
    let expected = BinarySearchIntegerTree([16, 10, 15, 6])
    
    actual.remove(5)
    
    XCTAssertEqual(actual, expected)
  }
  
  func test_remove_two_children_node() {
    var actual = BinarySearchIntegerTree([16, 5, 10, 15, 3])
    let expected = BinarySearchIntegerTree([16, 10, 3, 15])
    
    actual.remove(5)
    
    XCTAssertEqual(actual, expected)
  }
  
  func test_remove_root_two_children_node() {
    var actual = BinarySearchIntegerTree([16, 5, 10, 15, 3, 6, 20])
    let expected = BinarySearchIntegerTree([20, 5, 10, 15, 3, 6])
    
    actual.remove(16)
    
    XCTAssertEqual(actual, expected)
  }
  
  func test_removeTree_root_1_level() {
    var tree = BinarySearchIntegerTree.empty.inserting(1)
    tree.remove(treeUnder: 1)
    
    XCTAssertEqual(tree, .empty)
  }
  
  func test_removeTree_root_3_level() {
    tree.remove(treeUnder: 5)
    
    XCTAssertEqual(tree, .empty)
  }
  
  func test_removeTree_leaf_3_level() {
    tree.remove(treeUnder: 15)
    
    XCTAssertEqual(tree, BinarySearchIntegerTree([5, 10, 6]))
  }
  
  func test_removeTree_not_containing() {
    tree.remove(treeUnder: 1)
    
    XCTAssertEqual(tree, tree)
  }
  
  func test_removeTree_leaf_2_level() {
    var tree = BinarySearchIntegerTree([2, 1])
    tree.remove(treeUnder: 1)
    
    XCTAssertEqual(tree, BinarySearchIntegerTree([2]))
  }
  
  func test_traversals_preOrder() {
    tree.traverse(method: .preOrder) { [weak self] value, _ in
      self?.capturedItems.append(value)
    }
    
    XCTAssertEqual(capturedItems, [5,10,6,15])
  }
  
  func test_traversals_inOrder() {
    tree.traverse(method: .inOrder) { [weak self] value, _ in
      self?.capturedItems.append(value)
    }
    
    XCTAssertEqual(capturedItems, [5,6,10,15])
  }
  
  func test_traversals_postOrder() {
    tree.traverse(method: .postOrder) { [weak self] value, _ in
      self?.capturedItems.append(value)
    }
    
    XCTAssertEqual(capturedItems, [6,15,10,5])
  }
  
  func test_height(){
    var tree: BinarySearchIntegerTree = .empty
    tree.insert(5)
    
    XCTAssertEqual(tree.height, 1)
    
    tree.insert(10)
    
    XCTAssertEqual(tree.height, 2)
    
    tree.insert(15)
    
    XCTAssertEqual(tree.height, 3)
    
    tree.insert(6)
    
    XCTAssertEqual(tree.height, 3)
  }
  
  func test_contains_bool(){
    [5, 5, 10, 15, 6].forEach{
      XCTAssertTrue(tree.contains($0))
    }
  }
  
  func test_search_path(){
    XCTAssertEqual(tree.search(6), .node(value: 5, .init(.node(value: 10, .init(.node(value: 6, .noDescendent))))))
    XCTAssertEqual(tree.search(1), .empty)
  }
  
  func test_contains_other_tree(){
    XCTAssertTrue(tree.contains(tree5_10_6_15))
    XCTAssertTrue(tree5_10_6_15.contains(tree))
    XCTAssertTrue(tree5_10_6_15.contains(tree10_6_15))
    XCTAssertTrue(tree.contains(.empty))
    XCTAssertTrue(BinarySearchIntegerTree.empty.contains(.empty))
  }
  
  func test_string_preOrder(){
    var paths = [String]()
    let tree = BinaryTree<String>(["abc", "bca", "acb", "ab", "ca"])
    
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
  
  private let tree5_10_6_15: BinarySearchIntegerTree = .node(
    value: 5,
    .init(
      .empty,
      .node(
        value: 10, .init(
          .node(
            value: 6,
            .noDescendent
          ), .node(
            value: 15,
            .noDescendent
          )
        )
      )
    )
  )
  
  private let tree10_6_15: BinarySearchIntegerTree = .node(
    value: 10, .init(
      .node(
        value: 6,
        .noDescendent
      ), .node(
        value: 15,
        .noDescendent
      )
    )
  )
  
  static var allTests = [
    ("test_init", test_init),
    ("test_traversals_preOrder", test_traversals_preOrder),
    ("test_traversals_inOrder", test_traversals_inOrder),
    ("test_traversals_postOrder", test_traversals_postOrder),
    ("test_string_preOrder", test_string_preOrder),
    ("test_min_no_right_tree", test_min_no_right_tree),
    ("test_min_right_tree", test_min_right_tree),
    ("test_remove_one_childed", test_remove_one_childed),
    ("test_remove_root_1_level", test_remove_root_1_level),
    ("test_remove_two_children_node", test_remove_two_children_node),
    ("test_remove_root_two_children_node", test_remove_root_two_children_node),
    ("test_removeTree_root_1_level", test_removeTree_root_1_level),
    ("test_removeTree_root_3_level", test_removeTree_root_3_level),
    ("test_removeTree_not_containing", test_removeTree_not_containing),
    ("test_removeTree_leaf_2_level", test_removeTree_leaf_2_level),
    ("test_removeTree_leaf_3_level", test_removeTree_leaf_3_level),
    ("test_contains_other_tree", test_contains_other_tree),
    ("test_contains_bool", test_contains_bool),
    ("test_height", test_height),
  ]
}
