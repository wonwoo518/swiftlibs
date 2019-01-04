public struct ArrayStack<T>{

    fileprivate var elements = [T]()
    public init(){}
    public init<S:Sequence>(_ s:S) where S.Iterator.Element == T{
        elements = Array(s)
    }
    
    mutating func pop() -> T? {
        return elements.popLast()
    }
    
    mutating func push(e:T) -> Void {
        elements.append(e)
    }
}

var stack = ArrayStack([1,2,3])
print(stack.pop()!)


extension ArrayStack : ExpressibleByArrayLiteral{
    public init(arrayLiteral elements: T...){
        self.init(elements)
    }
}

stack = [4,5,6] //ExpressibleByArrayLiteral
print(stack.pop()!)

extension ArrayStack : CustomStringConvertible, CustomDebugStringConvertible{
    public var description: String {
        get{
            return "item is \(elements)"
        }
    }
    
    public var debugDescription: String {
        get{
            return "item is \(elements)"
        }
    }
}

print(stack)

extension ArrayStack : Sequence{
    public func makeIterator() -> AnyIterator<T> {
        return AnyIterator(IndexingIterator(_elements: self.elements.lazy.reversed()))
    }
}

for el in stack {
    print(el)
}

