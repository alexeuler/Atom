enum Event: AtomEvent {
    case AddTodo(name: String)
    case ToggleTodo(key: Int)
}
