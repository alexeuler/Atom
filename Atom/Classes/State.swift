struct AtomState<Event:AtomEvent>
{
    func react(event: Event) -> AtomState<Event>
    {
        return self
    }
}