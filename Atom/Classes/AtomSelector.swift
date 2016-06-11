class AtomSelectorKeychain {
    private var keys: [Any]
    
    init(keys: Any...) {
        self.keys = keys
    }
    
    public func getKey() -> Any {
        return keys.removeAtIndex(0)
    }
}


protocol AtomSelector {
    // parent state class
    static var parentClass: AtomSelector.Type { get }
    
    // Given the parent object and keychain (a set of keys), return self from the parent
    static func resolve(parent: AtomSelector, keychain: AtomSelectorKeychain) -> Self
}

extension AtomSelector {
//    TODO make AppState protocol to signal final class and take its instance
    static func select(ancestor: AtomSelector, keychain: AtomSelectorKeychain) -> Self {
        var classes: [AtomSelector.Type] = []
        classes.append(parentClass)
        var currentClass = parentClass
        while (currentClass != ancestor.dynamicType) {
            classes.append(parentClass)
            currentClass = currentClass.parentClass
        }
        var currentInstance = ancestor
        for klass in classes.reverse() {
            currentInstance = klass.resolve(currentInstance, keychain: keychain)
        }
        return currentInstance as! Self
    }
}
