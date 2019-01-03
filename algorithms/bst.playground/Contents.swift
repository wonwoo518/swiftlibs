import UIKit

class BinarySearchTree<T:Comparable>{
    class Node<T>{
        var val:T
        var left:Node? = nil
        var right:Node? = nil
        
        init(val:T) {
            self.val = val
        }
        
    }

    var rootNode:Node<T>? = nil

    func insert(insertItem:T){
        if rootNode == nil{
            rootNode = Node(val: insertItem)
            return
        }
        
        var curNode:Node<T>? = nil
        var parentNode = rootNode
        
        while parentNode != nil {
            
            if parentNode?.val == insertItem{
                return
            }
            
            if parentNode?.val > insertItem{
                parentNode = parentNode?.right
                continue
            }
            
            if parentNode?.val < insertItem{
                
            }
        }
        
    }
    
    
    func traverse(searchVal:T){
        print("")
    }
    
    func showTree(){
    }
    
    func delete(deleteItem:T){
    }
}


