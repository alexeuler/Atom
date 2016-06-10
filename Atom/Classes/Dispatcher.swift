class AtomDispatcher<E:AtomEvent>
{
    class var instance: AtomDispatcher<E>
    {
        return AtomDispatcherInstanceHolder.instance(E)
    }

    func performAction(action: E)
    {
        print("dispatcher \(unsafeAddressOf(self)) react to event \(action)")
    }
}

// in according to swift denied use static vars inside generic classes, i did this shit
class AtomDispatcherInstanceHolder
{
    static var holder: AnyObject!

    class func instance<E where E:AtomEvent>(_: E.Type) -> AtomDispatcher<E>
    {
        if holder == nil {
            holder = AtomDispatcher<E>()
        }

        return holder as! AtomDispatcher<E>
    }
}