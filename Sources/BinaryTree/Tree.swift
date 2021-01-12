public enum Tree<Element, Children> {
  case empty
  indirect case node(value: Element, Children)
}
