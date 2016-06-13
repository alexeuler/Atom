protocol AtomSelector {
    // parent state class
    static var parentClass: AtomSelector.Type { get }
}

extension AtomSelector {
    
    static func select(keys: Int...) -> Self {
        var classes: [AtomSelector.Type] = []
        var currentClass = self as AtomSelector.Type
        while !(currentClass is AtomGlobalState.Type) {
            classes.append(parentClass)
            currentClass = currentClass.parentClass
        }
        let instance = (currentClass as! AtomGlobalState.Type).instance
        let result = resolveHierarchy(instance, classes: classes, keys: keys) as? Self
        if result == nil {
            fatalError("AtomSelector: unable to resolve \(self) by keys: \(keys)")
        }
        return result!
    }
    
    static func select(ancestor: AtomSelector, keys: Int...) -> Self {
        var classes: [AtomSelector.Type] = []
        var currentClass = self as AtomSelector.Type
        while (currentClass != ancestor.dynamicType) && !(currentClass is AtomGlobalState.Type) {
            classes.append(parentClass)
            currentClass = currentClass.parentClass
        }
        if currentClass is AtomGlobalState.Type {
            if !(ancestor is AtomGlobalState) {
                fatalError("AtomSelector: reached the end of the class hierarchy and did not find \(ancestor)")
            }
        }
        let result = resolveHierarchy(ancestor, classes: classes, keys: keys) as? Self
        if result == nil {
            fatalError("AtomSelector: unable to resolve \(self) by keys: \(keys)")
        }
        return result!
    }
    
    private static func resolveHierarchy(instance: AtomSelector, classes: [AtomSelector.Type], keys: [Int]) -> AtomSelector? {
        var localKeys = keys
        var current: AtomSelector? = instance
        for klass in classes {
            current = resloveChild(current!, childType: klass, keys: &localKeys)
            if (current == nil) { return nil }
        }
        return current
    }
    
    private static func resloveChild(parent: AtomSelector, childType: AtomSelector.Type, inout keys: [Int]) -> AtomSelector? {
        let mirror = Mirror(reflecting: parent)
        let unwrappedInstances: [Any] = mirror.children
            .filter { $0.value != nil }
            .map { child in
                let childMirror = Mirror(reflecting: child.value)
                return childMirror.displayStyle == .Optional ?
                    childMirror.children.first!.value : child.value
        }
        for instance in unwrappedInstances {
            if instance.dynamicType == childType { return instance as? AtomSelector }
            let mirror = Mirror(reflecting: instance)
            if mirror.displayStyle == .Collection {
                let key = keys[0]
                if mirror.children.count > IntMax(key) {
                    let element = mirror.children[AnyForwardIndex(key)].value
                    if element.dynamicType == childType {
                        keys.removeAtIndex(0)
                        return element as? AtomSelector
                    }
                }
            }
        }
        return nil
    }
}
