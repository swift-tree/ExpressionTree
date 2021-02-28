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
    .package(path: "../BinaryTree"),
    //  .package(url: "https://github.com/erkekin/BinaryTree.git", .exact("0.1.5"))
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
