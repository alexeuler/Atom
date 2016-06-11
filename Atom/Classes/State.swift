//class State {
//
//    init() {
//
//    }
//
//    func react(state: State?, event: Event) -> State {
//        guard let state =
//        return state ?? State()
//    }
//}
//
//extension State {
//
//}

protocol AtomState {
    associatedtype AtomEvent
    static var instance: Self { get }
    static func react(state: Self?, event: AtomEvent) -> Self
    static func initial() -> Self
}

enum MyEvent {
    case A
    case B
}

struct MyState: AtomState {
    typealias AtomEvent = MyEvent
    
    var x: Int
    
    static func react(state: MyState?, event: AtomEvent) -> MyState {
        switch event {
        case .A:
            return MyState(x: 1)
        default:
            return state ?? MyState(x: 0)
        }
    }
    
    static func initial() -> MyState {
        return MyState(x: 0)
    }
}

extension AtomState {
    static func react(state: Self?, event: AtomEvent) -> Self {
        return state ?? initial()
    }
    
    static var instance: Self {
        get { return initial()  }
    }
    
    func serialize() -> String {
        return anyToString(self)
    }
}

private func anyToString(value: Any?, key:String? = nil, indent: String = "", doIndent: Bool = true) -> String {
    var result = doIndent ? indent : ""
    if key != nil { result += "\(key!): " }
    guard let unwrapped = value else {return result + String(value)}
    let mirror = Mirror(reflecting: unwrapped)
    if let type = mirror.displayStyle {
        
        switch type {
        case .Optional:
            for child in mirror.children {
                result += anyToString(child.value, key: nil, indent: indent, doIndent: false)
            }
            return result
            
        case .Collection, .Struct, .Dictionary:
            let closingSymbols = type == .Collection ? ["[", "]"] : ["{", "}"]
            if mirror.children.count == 0 {
                result += closingSymbols.joinWithSeparator("")
                return result
            }
            
            result += closingSymbols[0] + "\n"
            for (index, child) in mirror.children.enumerate() {
                let key = type == .Collection ? nil : child.label
                result += anyToString(child.value, key: key, indent: indent + "  ")
                if index != Int(mirror.children.count) - 1 {result += ","}
                result += "\n"
            }
            result += indent + closingSymbols[1]
            
            return result
            
        default:
            result += String(unwrapped)
            return result
        }
    } else {
        result += String(unwrapped)
        return result
    }
    
}
