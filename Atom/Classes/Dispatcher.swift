class Dispacher {
    
    static let instance = Dispacher()
    private var eventClass: AnyClass?
    
    func registerEventClass(klass: AnyClass) {
        eventClass = klass
    }
}
