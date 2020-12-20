public extension Tree {
  var height: Int { children.map{$0.height + 1} ?? 0 }
}
