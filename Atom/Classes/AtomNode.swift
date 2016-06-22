public protocol AtomNode {
    // parent state class
    static var parentClass: AtomNode.Type { get }
}

extension AtomNode {
    
    static func select(ancestor: AtomNode, keys: Int...) -> Self {
        var classes: [AtomNode.Type] = []
        var currentClass = self as AtomNode.Type
        while (currentClass != ancestor.dynamicType) {
            classes.append(currentClass)
            currentClass = currentClass.parentClass
        }
        let result = resolveHierarchy(ancestor, classes: classes, keys: keys) as? Self
        if result == nil {
            fatalError("AtomNode: unable to resolve \(self) by keys: \(keys)")
        }
        return result!
    }
    
    private static func resolveHierarchy(instance: AtomNode, classes: [AtomNode.Type], keys: [Int]) -> AtomNode? {
        var localKeys = keys
        var current: AtomNode? = instance
        for klass in classes {
            current = resloveChild(current!, childType: klass, keys: &localKeys)
            if (current == nil) { return nil }
        }
        return current
    }
    
    private static func resloveChild(parent: AtomNode, childType: AtomNode.Type, inout keys: [Int]) -> AtomNode? {
        let mirror = Mirror(reflecting: parent)
        let unwrappedInstances: [Any] = mirror.children
            .filter { $0.value != nil }
            .map { child in
                let childMirror = Mirror(reflecting: child.value)
                return childMirror.displayStyle == .Optional ?
                    childMirror.children.first!.value : child.value
        }
        for instance in unwrappedInstances {
            if instance.dynamicType == childType { return instance as? AtomNode }
            let mirror = Mirror(reflecting: instance)
            if mirror.displayStyle == .Collection {
                let key = keys[0]
                if mirror.children.count > IntMax(key) {
                    let element = mirror.children[AnyForwardIndex(key)].value
                    if element.dynamicType == childType {
                        keys.removeAtIndex(0)
                        return element as? AtomNode
                    }
                }
            }
        }
        return nil
    }
}
