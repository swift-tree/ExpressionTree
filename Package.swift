// swift-tools-version:5.2

import PackageDescription

let package = Package(
  name: "BinaryTree",
  products: [
    .library(
      name: "BinaryTree",
      targets: ["BinaryTree"]),
  ],
  dependencies: [],
  targets: [
    .target(
      name: "BinaryTree",
      dependencies: []),
    .testTarget(
      name: "BinaryTreeTests",
      dependencies: ["BinaryTree"]),
  ]
)
