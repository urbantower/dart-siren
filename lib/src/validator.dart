part of siren;

/**
 * This node validator allow all elements
 */
class AllowAllNodeValidator implements NodeValidator {
  @override
  bool allowsAttribute(Element element, String attributeName, String value) {
    return true;
  }

  @override
  bool allowsElement(Element element) {
    return true;
  }
}