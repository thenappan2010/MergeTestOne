import UIKit

var str = "Hello, playground"
struct Stack<Element> {

    /// The storage/stack itself.
    private var storage = [Element]()

    /// - parameter capacity: The storage capacity of the stack.
    init(capacity: Int) {
        storage.reserveCapacity(capacity)
    }

    /// Pushes element on the stack.
    /// - parameter element: The element object to be pushed to the stack.
    mutating func push(_ element: Element) {
        if storage.count == storage.capacity { storage.removeFirst(1) }
        storage.append(element)
    }

    /// Returns the top `n` elements from the stack.
    /// - parameter n: The number of elements to be returned from top of the stack.
    /// - returns an array of top `n` elements from the stack.
    func peek(_ n: Int) -> [Element] { storage.suffix(n) }

    /// Pops and returns the top element from the stack.
    /// - returns The element at the top of the stack.
    @discardableResult mutating func pop() -> Element? { storage.popLast() }

    /// Removes all elements from the Stack.
    @discardableResult mutating func removeAll() -> Bool {
        storage.removeAll()
        return storage.isEmpty
    }

    ///The number of elements in the stack.
    /// - returns The count of stack
    func size() -> Int {
        storage.count
    }
}


var contextStack = Stack<Int>(capacity: 10)
contextStack.push(3)
contextStack.peek(4)

public struct AppContextData {
    /// Name of the page in client app from where context is pushed.
    let pageName: String

    /// Name of the module to which pageName belongs.
    let moduleName: String

    /// Dictionary containing meta-details about the screen.
    let pageMetadata: [String: Any?]

    public init(pageName: String,
                moduleName: String,
                pageMetadata: [String: Any?]) {
        self.pageName = pageName
        self.moduleName = moduleName
        self.pageMetadata = pageMetadata
    }
}


extension Dictionary {
    func jsonData() -> Data? {
        do {
            return try JSONSerialization.data(withJSONObject: self, options: [])
        } catch {
            return nil
        }
    }
}

var metadata: [String: Any] = [:]
metadata["location"] = ""//data.invocationSource
metadata["userTimezone"] = TimeZone.current.abbreviation()
metadata["spid"] = "adfadfasdf"

JSONSerialization.isValidJSONObject([AppContextData(pageName: "p1", moduleName: "m1", pageMetadata: ["one": "two"])])
metadata["appContext"] = [AppContextData(pageName: "p1", moduleName: "m1", pageMetadata: ["one": "two"])]
let toData = metadata.jsonData()
print(toData)
