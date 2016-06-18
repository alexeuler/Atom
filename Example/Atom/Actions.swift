class Actions {
    static let instance = Actions()
    
    func addTodo(name: String) {
        Dispatcher.instance.dispatch(Event.AddTodo(name: name))
    }
    
    func toggleTodo(key: Int) {
        Dispatcher.instance.dispatch(Event.ToggleTodo(key: key))
    }
}
