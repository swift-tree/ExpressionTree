// swift-tools-version:5.7.1

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
    .package(url: "https://github.com/swift-tree/BinaryTree.git", exact: "1.0.5")
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
