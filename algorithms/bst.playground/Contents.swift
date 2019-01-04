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
            
            if curNode.val < insertItem {
                if let child = curNode.right{
                    parentNode = child
                    continue
                }
                
                curNode.right = Node(val: insertItem)
                return
            }
            
            if curNode.val > insertItem {
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
        print(rootNode?.val ?? "")
        traverse(rootNode?.right)
    }
    
    func search(val:T)->Bool{
        return search(root:rootNode, val:val)
    }
    private func search(root:Node<T>?, val:T)->Bool{
        
        guard let root = root else{
            return false
        }
        
        if root.val == val{
            return true
        }
        
        if root.val > val{
            return search(root:root.left, val:val)
        }
        
        return search(root:root.right, val:val)
    }
    
    func showTree(){
    }
    
    func delete(deleteItem:T){
    }
}

extension BinarySearchTree{
    
}


var bst = BinarySearchTree<Int>()
bst.insert(insertItem: 5)
bst.insert(insertItem: 2)
bst.insert(insertItem: 8)
bst.insert(insertItem: 1)
bst.insert(insertItem: 3)
bst.insert(insertItem: 4)
bst.traverse()
print("tree has value = \(bst.search(val:8))")
