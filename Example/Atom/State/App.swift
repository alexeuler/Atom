extension State {
    struct App: AtomState, AtomSelector {
        typealias AtomStateEvent = Event
        static var instance = App.initial()
        static var parentClass: AtomSelector.Type = App.self
        
        var todos: [Todo]
        
        static func initial() -> App {
            return App(todos: [])
        }
        
    }
}
