// swift-tools-version:5.2

import PackageDescription

let package = Package(
  name: "BinaryTree",
  products: [
    .library(
      name: "BinaryTree",
      targets: ["BinaryTree"]),
  ],
  dependencies: [.package(url: "https://github.com/erkekin/Tree.git", .exact("0.1.5"))],
  targets: [
    .target(
      name: "BinaryTree",
      dependencies: ["Tree"]),
    .testTarget(
      name: "BinaryTreeTests",
      dependencies: ["BinaryTree", "Tree"]),
  ]
)
