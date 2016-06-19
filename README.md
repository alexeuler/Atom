##Getting started

#### Installation

Atom is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Atom"
```

#### Defining core classes

##### Event class

Define and enum, containing all possible events with parameters, e.g.

```
enum Event: AtomEvent {
    case AddTodo(name: String)   
    case ToggleTodo(key: Int)  
}
```

##### States

For each state implement AtomState protocol - define `parentClass` and impelement `react` and 
`initial` functions, e.g.
```
      struct Todo: AtomState {
          var name: String
          var checked: Bool
          
          typealias EventType = Event
          
          static var parentClass: AtomNode.Type = App.self
          
          static func react(optionalCurrent: Todo?, event: EventType) -> Todo {
              guard var current = optionalCurrent else { return initial() }
              
              switch event {
              case .ToggleTodo:
                  current.checked = !current.checked
              default:
                  break
              }
              
              return current
          }
          
          static func initial() -> Todo {
              return Todo(name: "", checked: false)
          }
      }
```

##### Root state
In addition to `AtomState` methods, Root State implement AtomRoot protocol, i.e. must hold a static 
instance of itself, e.g.:

```
    struct App: AtomState, AtomRoot {
        typealias EventType = Event
        static var instance = App.initial()
        static var parentClass: AtomNode.Type = App.self
        
        var todos: [Todo]
        
        static func react(optionalCurrent: App?, event: Event) -> App {
            guard var current = optionalCurrent else { return App.initial() }
            switch event {
            case .AddTodo(let name):
                let todo = Todo(name: name, checked: false)
                current.todos.append(todo)
                return current
            case .ToggleTodo(let key):
                current.todos[key] = Todo.react(current.todos[key], event: .ToggleTodo(key: key))
                return current
            }
        }
        
        static func initial() -> App {
            return App(todos: [])
        }
        
    }
```

##### Atom class
Define global Atom class implementing `AtomProtocol` and use it to dispatch events:
```
  class Atom: AtomProtocol {
      typealias RootType = State.App
  }
```

Now you can use Atom class to dispatch events, e.g. `Atom.dispatch(Event.AddTodo(name: titleTextField.text ?? ""))`

##Todo
- Add logging as a middleware
- Add time machine screen (i.e. view controller with all states history and ability to rollback 
states)
- Add router
- Add props change strategies


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Description

### State

State is the minimal required data to reconstruct the whole state of the app. State is constructed
to be as close to view model as possible

### Event

Event is the simple change of state

### Action

Action emits one or more events. Every state change is made by actions
 
### Props

Props are the viewmodel required to render a view (including that of viewcontroller)

### Transformers

Transform state into props. The simpiest transformer just selects a part of the state relevant for 
 the current view.
 

## Author

Alexey Karasev, karasev.alexey@gmail.com

## License

Atom is available under the MIT license. See the LICENSE file for more info.
