class Actions {
    static let instance = Actions()
    
    func addTodo(name: String) {
        Atom.dispatch(Event.AddTodo(name: name))
    }
    
    func toggleTodo(key: Int) {
        Atom.dispatch(Event.ToggleTodo(key: key))
    }
}
