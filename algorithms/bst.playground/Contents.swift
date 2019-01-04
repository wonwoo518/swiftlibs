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
        
        var parentNode = rootNode
        
        while var curNode = parentNode {
            
            if curNode.val == insertItem {
                return
            }
            
            if curNode.val > insertItem {
                if let child = curNode.right{
                    curNode = child
                    continue
                }
                
                curNode.right = Node(val: insertItem)
                return
            }
            
            if curNode.val < insertItem {
                if let child = curNode.left{
                    parentNode = child
                    continue
                }
                
                curNode.left = Node(val: insertItem)
                return
            }
        }
    }
    
    
    func traverse(){
        traverse(rootNode)
    }

    private func traverse(_ rootNode:Node<T>?){
        
        if rootNode == nil{
            return
        }
   
        traverse(rootNode?.left)
        print(rootNode?.val)
        traverse(rootNode?.right)
    }
    
    
    func showTree(){
    }
    
    func delete(deleteItem:T){
    }
}


var bst = BinarySearchTree<Int>()
bst.insert(insertItem: 5)
bst.insert(insertItem: 2)
bst.insert(insertItem: 8)
bst.insert(insertItem: 1)
bst.insert(insertItem: 3)
bst.traverse()

