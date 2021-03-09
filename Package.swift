// swift-tools-version:5.2

import PackageDescription

let package = Package(
  name: "ExpressionTree",
  products: [
    .library(
      name: "ExpressionTree",
      targets: ["ExpressionTree"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/swift-tree/BinaryTree.git", .exact("1.0.0"))
  ],
  targets: [
    .target(
      name: "ExpressionTree",
      dependencies: ["BinaryTree"]
    ),
    .testTarget(
      name: "ExpressionTreeTests",
      dependencies: ["ExpressionTree", "BinaryTree"]
    ),
  ]
)
