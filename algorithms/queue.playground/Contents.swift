// create by wonwoo.lee
import UIKit

class MyQueueV1<T>{
    private var array:Array<T> = Array<T>()
    func isEmpty() -> Bool {
        return array.isEmpty
    }
    
    func count()->Int{
        return array.count
    }

    func enque(val:T){
        array.append(val)
    }
    
    func deque()->T?{
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
//q.enque(val: "1")
//q.enque(val: "2")
//q.enque(val: "3")
//q.enque(val: "4")
//q.qprint()
//q.deque()
//q.qprint()


//array copy issue customize
//array first pop시 뒤의 원소를 모두 앞으로 한칸씩 옮기는 작업 효율화.
class MyQueueV2<T>{
    private var head:Int = 0
    private var array:Array<T?> = Array<T?>()
    func isEmpty() -> Bool {
        return array.isEmpty
    }
    
    func count()->Int{
        return array.count
    }
    
    func enque(val:T){
        
        array.append(val)
    }
    
    func deque()->T?{
        if array.isEmpty {
            return nil
        }
        
        var popVal = array[head]
        array[head] = nil
        head += 1
        
        arrayRearrange()
        
        return popVal
    }
    
    private func arrayRearrange(){
        var wasteRate:CGFloat = 0.0
        wasteRate = array.count < 5 ? 100.0 : CGFloat((head) * 100) / CGFloat(array.count)
        if wasteRate > 50.0{
            array.removeFirst(head)
            head = 0
        }
    }
    
    func qprint(){
        print(array)
    }
}

//Test Code
//var q = MyQueueV2<String>()
//q.enque(val: "하늘")
//q.enque(val: "땅")
//q.enque(val: "바람")
//q.enque(val: "구름")
//q.enque(val: "비")
//q.qprint()
//q.deque()
//q.qprint()
//q.deque()
//q.qprint()
//q.deque()
//q.qprint()
//q.deque()
//q.qprint()
//q.enque(val: "1")
//q.enque(val: "2")
//q.enque(val: "3")
//q.enque(val: "4")
//q.qprint()
//q.deque()
//q.qprint()
//q.deque()
//q.qprint()
//q.deque()
//q.qprint()

//circular queue
class MyQueueV3<T>{
    private var array:Array<T> = Array<T>()
    func isEmpty() -> Bool {
        return array.isEmpty
    }
    
    func count()->Int{
        return array.count
    }
    
    func enque(val:T){
        array.append(val)
    }
    
    func deque()->T?{
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


