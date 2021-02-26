// swift-tools-version:5.2

import PackageDescription

let package = Package(
  name: "BinarySearchTree",
  products: [
    .library(
      name: "BinarySearchTree",
      targets: ["BinarySearchTree"]),
  ],
  dependencies: [
   .package(path: "../BinaryTree"),
    //  .package(url: "https://github.com/erkekin/BinaryTree.git", .exact("0.1.5"))
  ],
  targets: [
    .target(
      name: "BinarySearchTree",
      dependencies: ["BinaryTree"]),
    .testTarget(
      name: "BinarySearchTreeTests",
      dependencies: ["BinarySearchTree", "BinaryTree"]),
  ]
)
