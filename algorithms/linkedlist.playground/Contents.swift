// create by wonwoo.lee
import UIKit

class Node<T>{
    var val:T
    var next:Node?
    init(_ val:T) {
        self.val = val
    }
    deinit {
        print("deinit - val \(self.val)")
    }
}

class LinkedList<T>{
    
    private var head:Node<T>? = nil
    func append(node:Node<T>){
        
        if head != nil {
            var curNode:Node<T>? = head
            while (curNode?.next) != nil {
                curNode = curNode?.next
            }
            
            curNode?.next = node
            
        }else{
            head = node
        }
    }
    
    func append(_ val:T){
        append(node: Node<T>(val))
    }
    
    func lprint(){
        var node:Node<T>? = head
        while node != nil {
            print(node?.val)
            node = node?.next
        }
    }
    
    func insert(val:T, at:Int)->Bool{
        return insert(node:Node<T>(val), at:at)
    }
    func insert(node:Node<T>, at:Int)->Bool{
        var curNode = head
        var idx:Int = 0
        while curNode != nil {
            if (at-1) == idx{
                node.next = curNode?.next
                curNode?.next = node
                return true
            }else if at == 0{
                node.next = head
                head = node
                return true
            }
            
            curNode = curNode?.next
            idx += 1
        }
        
        return false
    }
    
    func removeAll(){
        head = nil
    }
    
    func removeAt(at:Int)->Bool{
        var curNode = head
        var prevNode:Node<T>? = nil
        var idx:Int = 0
        while curNode != nil {
            if at == 0{
                head = head?.next
                return true
            }else if at == idx{
                prevNode?.next = curNode?.next
                return true
            }

            prevNode = curNode
            curNode = curNode?.next
            idx += 1
        }
        
        return false
    }
    
    func removeLast(){
        
    }
}

var ll = LinkedList<Int>()
ll.append(1)
ll.append(10)
ll.append(11)
ll.append(9)
ll.append(node: Node<Int>(113))
ll.insert(val: 100, at: 1)
ll.lprint()
ll.removeAt(at: 5)
ll.lprint()
ll.removeAll()


