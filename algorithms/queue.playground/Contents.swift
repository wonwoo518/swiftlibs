// create by wonwoo.lee
import UIKit

struct MyQueueV1<T>{
    private var array:Array<T> = Array<T>()
    func isEmpty() -> Bool {
        return array.isEmpty
    }
    
    func count()->Int{
        return array.count
    }

    mutating func enqueue(val:T){
        array.append(val)
    }
    
    mutating func dequeue()->T?{
        if array.isEmpty {
            return nil
        }

        return array.removeFirst()
    }
    
    func qprint(){
        array.map{
            print($0)
        }
    }
}
//Test Code
//var q = MyQueueV1<String>()
//q.enqueue(val: "1")
//q.enqueue(val: "2")
//q.enqueue(val: "3")
//q.enqueue(val: "4")
//q.qprint()
//q.dequeue()
//q.qprint()


//array copy issue customize
//array first pop시 뒤의 원소를 모두 앞으로 한칸씩 옮기는 작업 효율화.
struct MyQueueV2<T>{
    private var head:Int = 0
    private var array:Array<T?> = Array<T?>()
    
    public init<S: Sequence>(_ elements: S) where S.Iterator.Element == T? {
        array.append(contentsOf: elements)
    }
    
    func isEmpty() -> Bool {
        return array.isEmpty
    }
    
    func count()->Int{
        return array.count
    }
    
    mutating func enqueue(val:T){
        
        array.append(val)
    }
    
    mutating func dequeue()->T?{
        if array.isEmpty {
            return nil
        }
        
        let popVal = array[head]
        array[head] = nil
        head += 1
        
        arrayRearrange()
        
        return popVal
    }
    
    private mutating func arrayRearrange(){
        var wasteRate:CGFloat = 0.0
        wasteRate = array.count < 5 ? 100.0 : CGFloat((head) * 100) / CGFloat(array.count)
        if wasteRate > 50.0{
            array.removeFirst(head)
            head = 0
        }
    }
}

extension MyQueueV2 : CustomStringConvertible, CustomDebugStringConvertible{
    public var description: String {
        get{
            return array.description
        }
    }
    
    public var debugDescription: String {
        get{
            return array.description
        }
    }
}

extension MyQueueV2 : ExpressibleByArrayLiteral{
    public init(arrayLiteral elements: T...){
        self.init(elements)
    }
}

extension MyQueueV2 : Sequence {
    public func makeIterator() -> AnyIterator<T?> {
        return AnyIterator(IndexingIterator(_elements: array))
    }
}

////Test Code
//var q = MyQueueV2<String>()
var q = MyQueueV2<String>(["하늘", "땅", "바람", "구름", "비"])
print(q)
var q2:MyQueueV2<String> = ["하늘", "땅", "바람", "구름", "비"]
print(q2)

for el in q2{
    print(el)
}

//q.enqueue(val: "하늘")
//q.enqueue(val: "땅")
//q.enqueue(val: "바람")
//q.enqueue(val: "구름")
//q.enqueue(val: "비")
//print(q)
//q.dequeue()
//print(q)
//q.dequeue()
//print(q)
//q.dequeue()
//print(q)
//q.dequeue()
//print(q)
//q.enqueue(val: "1")
//q.enqueue(val: "2")
//q.enqueue(val: "3")
//q.enqueue(val: "4")
//print(q)
//q.dequeue()
//print(q)
//q.dequeue()
//print(q)
//q.dequeue()
//print(q)





