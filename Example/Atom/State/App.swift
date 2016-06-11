extension State {
    struct App: AtomState {
        typealias AtomEvent = Event
        private static let instance = App.initial()
        static var parent: AtomSelector.Type = App.self
        
        var todos: [Todo]
        
        static func resolve(parent: AtomSelector, keychain: AtomSelectorKeychain) -> App {
            return instance
        }
        
        static func initial() -> App {
            return App(todos: [])
        }
        
    }
}
