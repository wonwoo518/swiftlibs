//: Playground - noun: a place where people can play

import UIKit

class Node<T>{
    var val:T
    var next:Node?
    
    init(_ val:T) {
        self.val = val
    }
}

class LinkedList<T>{
    var head:Node<T>?
    
    func insertRear(node:Node<T>){
        var cur = head
        while true {
            if let next = cur?.next{
                cur = next
                continue
            }
            
            cur?.next = node
            return
        }
    }
    
    func insertAfter(prevNode:Node<T>, insertNode:Node<T>){
        var cur = head
        while true {
            if cur === prevNode{
                insertNode.next = cur?.next
                cur?.next = insertNode
                return
            }
            
            if let next = cur?.next{
                cur = next
                continue
            }
            
            return
        }
    }
    
    
    
    func delete(node:Node<T>){
        let cur = head?.next
        let prev = head
        while true {
            if cur === node{
                prev?.next = cur?.next
                cur?.next = nil
                return
            }
            
            cur?.next = cur?.next?.next
        }
    }
    
    func lprint(){
        while true {
            guard let n =  head?.next else{
                return
            }
            
            print("\(n.val)")
            head?.next = head?.next?.next
        }
    }
}

var lst = LinkedList<Int>()
lst.head = Node<Int>(-1)
lst.insertRear(node: Node(10))
let n11 = Node(11)
lst.insertRear(node: n11)
let n15 = Node(15)
lst.insertRear(node: n15)
lst.insertAfter(prevNode: n11, insertNode: Node(14))
lst.insertAfter(prevNode: n15, insertNode: Node(16))
lst.lprint()

