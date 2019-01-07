//Created by wonwoo.lee

import UIKit

class BinarySearchTree<T:Comparable>{
    class Node<T>{
        var val:T
        weak var parent:Node? = nil
        var left:Node? = nil{
            didSet{
                left?.nodePosition = .left
            }
        }
        var right:Node? = nil{
            didSet{
                right?.nodePosition = .right
            }
        }
        
        enum NodePosition {
            case left
            case right
            case none
        }
        var nodePosition:NodePosition = .none

        init(val:T) {
            self.val = val
        }

        deinit {
            print("deinit val = \(val)")
            parent = nil
            left = nil
            right = nil
        }
        
        func isLeaf()->Bool{
            if left == nil && right == nil{
                return true
            }
            
            return false
        }
        
    }

    var rootNode:Node<T>? = nil

    func insert(insertItem:T){
        if rootNode == nil{
            rootNode = Node(val: insertItem)
            return
        }
        
        var parentNode = rootNode
        
        while let curNode = parentNode {
            
            if curNode.val == insertItem {
                return
            }
            
            if curNode.val < insertItem {
                if let child = curNode.right{
                    parentNode = child
                    continue
                }
                
                curNode.right = Node(val: insertItem)
                curNode.right?.parent = curNode
                return
            }

            if curNode.val > insertItem {
                if let child = curNode.left{
                    parentNode = child
                    continue
                }

                curNode.left = Node(val: insertItem)
                curNode.left?.parent = curNode
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
        print("val = \((rootNode?.val)!) parent = \(rootNode?.parent?.val), left = \(rootNode?.left?.val), right = \(rootNode?.right?.val)")
        traverse(rootNode?.right)
    }
    
    func search(val:T)->Bool{
        return search(root:rootNode, val:val).0
    }
    private func search(root:Node<T>?, val:T)->(Bool, Node<T>?){
        
        guard let root = root else{
            return (false, nil)
        }
        
        if root.val == val{
            return (true, root)
        }
        
        if root.val > val{
            return search(root:root.left, val:val)
        }
        
        return search(root:root.right, val:val)
    }
    
    func delete(deleteItem:T){
        
        func deleteNode(node:Node<T>){
            print("node = \(node.val), posi = \(node.nodePosition)")
            switch node.nodePosition {
            case .left: node.parent?.left = nil
            case .right: node.parent?.right = nil
            default:
                return
            }
        }
        
        var searchNode = search(root:rootNode, val: deleteItem)
        
        //삭제하려는 노드가 없으면 그냥 리턴
        if searchNode.0 == false{
            return
        }
        
        guard var nodeToDelete = searchNode.1 else{
            return
        }
        
        //삭제하려는 노드가 리프이면 자신만 삭제
        if nodeToDelete.isLeaf(){
            deleteNode(node: nodeToDelete)
            return
        }

        //삭제하려는 노느가 자식이 있으면 left most또는 right least를 찾아서 삭제할 노드와 교체한다.
        var replaceNode = nodeToDelete.left != nil ? max(root:nodeToDelete.left!) : min(root: nodeToDelete.right!)
        switchNode(toDeleteNode:&nodeToDelete, toReplaceNode:&replaceNode!)
        
        //left most 또는 right least의 자식이 있으면 삭제할 노드를 leaf로 보낸다.
        if nodeToDelete.isLeaf() == false{
            if nodeToDelete.left != nil {
                switchNode(toDeleteNode: &nodeToDelete, toReplaceNode: &nodeToDelete.left!)
            }else{
                switchNode(toDeleteNode: &nodeToDelete, toReplaceNode: &nodeToDelete.right!)
            }
        }
        
        deleteNode(node: nodeToDelete)
    }
    
    func min(root:Node<T>)->Node<T>?{
        if let left = root.left{
            print("min = \(root.val)")
            return min(root: left)
        }
        
        print("min = \(root.val)")
        return root
    }
    
    func max(root:Node<T>)->Node<T>?{
        if let right = root.right{
            print("max = \(root.val)")
            return max(root: right)
        }
        print("max = \(root.val)")
        return root
    }
    
    func switchNode(toDeleteNode:inout Node<T>, toReplaceNode:inout Node<T>){

        var replaceVal = toReplaceNode.val
        var deleteVal = toDeleteNode.val
        
        var temp = toDeleteNode
        toDeleteNode = toReplaceNode
        toReplaceNode = temp
        
        toDeleteNode.val = deleteVal
        toReplaceNode.val = replaceVal
    }
}



//var bst = BinarySearchTree<Int>()
//bst.insert(insertItem: 5)
//bst.insert(insertItem: 2)
//bst.insert(insertItem: 8)
//bst.insert(insertItem: 1)
//bst.insert(insertItem: 3)
//bst.insert(insertItem: 4)
//bst.insert(insertItem: 100)
//bst.insert(insertItem: 80)
//bst.insert(insertItem: 7)
//bst.insert(insertItem: 110)
//print("tree has value = \(bst.search(val:8))")
//bst.delete(deleteItem: 8)
//bst.traverse()

var bstString = BinarySearchTree<String>()
bstString.insert(insertItem: "d")
bstString.insert(insertItem: "a")
bstString.insert(insertItem: "f")
bstString.insert(insertItem: "b")
bstString.insert(insertItem: "z")
bstString.insert(insertItem: "k")
bstString.insert(insertItem: "m")
bstString.delete(deleteItem: "f")
bstString.traverse()


