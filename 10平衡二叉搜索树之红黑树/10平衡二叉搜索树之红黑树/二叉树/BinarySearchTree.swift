//
//  BinarySearchTree.swift
//  08二叉树
//
//  Created by 华惠友 on 2020/10/23.
//

import Foundation

///二叉树
class BinarySearchTree<E: Comparable> {
    
    internal var size = 0
    ///根节点
    internal var root: TreeNode<E>?
    
    func createNode(element: E, parent: TreeNode<E>?) -> TreeNode<E> {
        return TreeNode(element: element, parent: parent)
    }
    
    ///返回根节点
    func rootNode() -> TreeNode<E>? {
        return root
    }
    
    ///元素的数量
    func count() -> Int {
        return size
    }
    
    ///是否为空
    func isEmpty() -> Bool {
        return size == 0
    }
    
    ///是否包含某个元素
    func contains(element: E) -> Bool {
        return node(element: element) != nil
    }
    
    ///清除所有元素
    func clear() {
        root = nil
        size = 0
    }
    
    ///添加元素到尾部
    @discardableResult
    func add(element: E) -> TreeNode<E> {
        ///1.是否是根节点, 是创建根节点
        if root == nil {
//            root = TreeNode(element: element, parent: nil)
            root = createNode(element: element, parent: nil)
            size += 1
            return root!
        }
        ///2.找到插入位置的父节点
        ///2.1.通过不断的跟节点比较
        ///2.2.小于节点的, 继续跟节点的左子节点比较
        ///2.3.大于节点的, 继续跟节点的右子节点比较
        ///2.4.等于节点的, 直接赋值返回
        ///2.4.直到比较到节点不存在, 此时就找到对应的父节点
        var parent = root
        var node = root
        var cmp = 0
        while node != nil {
            parent = node
            cmp = compare(element1: element, element2: node?.element)
            
            if cmp > 0 {
                node = node?.right ?? nil
            } else if cmp < 0 {
                node = node?.left ?? nil
            } else {
                node?.element = element
                return node!
            }
        }
        
        ///3.创建新节点
        let newNode = createNode(element: element, parent: parent)
        
        ///4.根据比较结果来决定是插入左边还是右边
        if cmp > 0 {
            parent?.right = newNode
        } else {
            parent?.left = newNode
        }
        size += 1
        return newNode
    }
    
    ///删除元素为element的节点
    @discardableResult
    func remove(element: E) -> TreeNode<E>? {
        let removeNode = node(element: element)
        remove(node: removeNode)
        return removeNode
    }
    
    ///删除节点为node的及诶点
    func remove(node: TreeNode<E>?) {
        guard var node = node else { return }
        
        size -= 1
        ///1.删除的是度为2的节点
        ///1.1.找到节点的前驱或者后继节点, 将前驱或者后继节点的值覆盖删除节点的值
        ///1.2.删除相应的前驱或者后继节点 (如果一个节点的度为2, 那么它的前驱或者后继节点的度只可能为 1 或者 0)
        if node.hasTwoChildren() {
            if let s = successor(node: node) {
                node.element = s.element
                node = s
            }
        }
        
        ///2.删除度为1的节点(包括前驱或者后继节点) [注意顺序]
        ///2.1.如果删除节点是左子节点
        ///2.1.1.如果删除节点的子节点是左子节点
        ///2.1.1.1.将删除节点的的左子节点的parent指向 删除节点的 父节点 [node.left.parent = node.parent] 改变 [子节点 -> 父节点] 指向
        ///2.1.1.2.将删除节点的父节点的 左子节点 指向 删除节点的 左子节点 [node.parent.left = node.left] 改变 [父节点 -> 子节点] 指向
        
        ///2.1.2.如果删除节点的子节点是右子节点
        ///2.1.2.1.将删除节点的的右子节点的parent指向 删除节点的 父节点 [node.right.parent = node.parent] 改变 [子节点 -> 父节点] 指向
        ///2.1.2.2.将删除节点的父节点的 左子节点 指向 删除节点的 右子节点 [node.parent.left = node.right] 改变 [父节点 -> 子节点] 指向
        
        ///2.2.如果删除节点是右子节点
        ///2.2.1.如果删除节点的子节点是左子节点
        ///2.2.1.1.将删除节点的的左子节点的parent指向 删除节点的 父节点 [node.left.parent = node.parent] 改变 [子节点 -> 父节点] 指向
        ///2.2.1.2.将删除节点的父节点的 右子节点 指向 删除节点的 左子节点 [node.parent.right = node.left] 改变 [父节点 -> 子节点] 指向
        
        ///2.2.2.如果删除节点的子节点是右子节点
        ///2.2.2.1.将删除节点的的右子节点的parent指向 删除节点的 父节点 [node.right.parent = node.parent] 改变 [子节点 -> 父节点] 指向
        ///2.2.2.2.将删除节点的父节点的 右子节点 指向 删除节点的 右子节点 [node.parent.right = node.right] 改变 [父节点 -> 子节点] 指向
        
        ///2.3.如果删除节点是根节点, 即没有父节点
        ///2.3.1改变父子节点指向即可
        if node.isLeaf() == false { ///度为1 , 度为2已经过滤了
            let replacement = node.left != nil ? node.left : node.right
            replacement?.parent = node.parent
            if node.parent == nil {
                root = replacement
            } else if node == node.parent?.left {
                node.parent?.left = replacement
            } else {
                node.parent?.right = replacement
            }
        }
        
        ///3.删除度为0的节点
        ///3.1.直接删除即可
        ///3.1.1.如果删除节点为左子节点, 将删除节点的父节点的左子节点 置为 nil即可 [node.parent.left = nil]
        ///3.1.1.如果删除节点为右子节点, 将删除节点的父节点的右子节点 置为 nil即可 [node.parent.right = nil]
        ///3.1.1.如果删除节点为根节点, 将根节点 置为 nil即可 [root = nil]
        if node.isLeaf() == true { ///叶子节点
            if node.parent == nil {
                root = nil
            } else {
                if node == node.parent?.left {
                    node.parent?.left = nil
                } else {
                    node.parent?.right = nil
                }
            }
        }
    }
    
    ///返回元素为element的节点
    func node(element: E) -> TreeNode<E>? {
        var node = root
        while node != nil {
            let cmp = compare(element1: element, element2: node?.element)
            if cmp == 0 {
                return node
            }
            if cmp > 0 {
                node = node?.right
            } else {
                node = node?.left
            }
        }
        return nil
    }
}

//MARK: - 遍历
extension BinarySearchTree {
    ///前序遍历
    func preorder() {
        preorder(node: root)
    }
    
    private func preorder(node: TreeNode<E>?) {
        guard let node = node else { return }
        
        print(node.toString())
        preorder(node: node.left)
        preorder(node: node.right)
    }
    
    ///中序遍历
    func inorder() {
        inorder(node: root)
    }
    
    private func inorder(node: TreeNode<E>?) {
        guard let node = node else { return }
        
        inorder(node: node.left)
        print(node.toString())
        inorder(node: node.right)
    }
    
    ///后续遍历
    func postorder() {
        postorder(node: root)
    }
    
    private func postorder(node: TreeNode<E>?) {
        guard let node = node else { return }
        
        postorder(node: node.left)
        postorder(node: node.right)
        print(node.toString())
    }
    
    ///层序遍历 [采用队列的数据结构]
    func levelOrder() {
        guard let root = root else { return }
        
        let queue = Queue<TreeNode<E>>()
        queue.enQueue(element: root)
        
        while queue.isEmpty() == false {
            if let node = queue.deQueue() {
                print(node.toString())
                if let left = node.left {
                    queue.enQueue(element: left)
                }
                if let right = node.right {
                    queue.enQueue(element: right)
                }
            }
        }
    }
}

//MARK: - 高度计算
extension BinarySearchTree {
    ///二叉树的高度 [递归]
    func getHeight() -> Int {
        return getHeight(node: root)
    }
    
    func getHeight(node: TreeNode<E>?) -> Int {
        guard let node = node else { return 0 }
        
        return 1 + max(getHeight(node: node.left), getHeight(node: node.right))
    }
    
    ///二叉树的高度 [迭代]
    /**
     层序遍历, 每遍历一层结束后高度 + 1
     */
    func getHeight2() -> Int {
        guard let root = root else { return 0 }
        
        ///深度
        var height = 0
        ///每层元素的个数
        var levelSize = 1
        
        let queue = Queue<TreeNode<E>>()
        queue.enQueue(element: root)
        while queue.isEmpty() == false {
            let node = queue.deQueue()
            levelSize -= 1
            
            if let left = node?.left {
                queue.enQueue(element: left)
            }
            
            if let right = node?.right {
                queue.enQueue(element: right)
            }
            
            if levelSize == 0 { ///表示要访问下一层了
                levelSize = queue.size()
                height += 1
            }
        }
        
        return height
    }
    
    ///是否为完全二叉树
    /**
     层序遍历
     1.如果度为2, 入队进行遍历
     2.如果度为1, 那么只能有左叶子节点, 没有右叶子节点, 否则不是完全二叉树
     3.当所有节点遍历结束后, 中途没有停止遍历, 则是完全二叉树
     */
    func isCompleteBinaryTree() -> Bool {
        guard let root = root else { return false }
        
        let queue = Queue<TreeNode<E>>()
        queue.enQueue(element: root)
        
        while queue.isEmpty() == false {
            let node = queue.deQueue()
            
            if node?.hasTwoChildren() == true {
                if let left = node?.left {
                    queue.enQueue(element: left)
                }
                if let right = node?.right {
                    queue.enQueue(element: right)
                }
            } else if node?.isLeaf() == false {
                if node?.left == nil, node?.right != nil {
                    return false
                }
            }
        }
        return true
    }
}

//MARK: - 前驱结点 & 后继节点
extension BinarySearchTree {
    ///前驱节点: 在二叉搜索树中, 前驱结点就是前一个比它小的节点, 即中序遍历时的前一个节点
    func predecessor(node: TreeNode<E>?) -> TreeNode<E>? {
        guard let node = node else { return nil }
        
        ///1.查找节点的左子树不为空 [node.left != nil]
        ///1.1.那么前驱节点就在查找节点的左子树的迭代右子树中, 直到某个节点的右子树为空 [node.left.right.right...]
        if node.left != nil {
            var p = node.left
            while p?.right != nil {
                p = p?.right
            }
            return p
        }
        
        
        ///2.查找节点的的左子树为空, 但父节点不为空
        ///2.1.查找节点为父节点的左子节点 [node == node.parent.left]
        ///2.1.1.前驱节点为查找节点的迭代父节点中, 那么前驱节点为 node.parent.parent 直到 该节点的父节点的右子节点为它自己 [node = node.parent.right], 前驱节点即为node.parent
        
        ///2.2.查找节点为父节点的右子节点 [node = node.parent.right]
        ///2.2.1.前驱节点为查找节点的父节点, node.parent
        
        if node.left == nil, node.parent != nil {
            var p: TreeNode<E>? = node
            //            if node == p?.parent?.left {
            while p != p?.parent?.right {
                p = p?.parent
            }
            return p?.parent
            //            } else {
            //                return p?.parent
            //            }
        }
        
        ///3.查找节点的左子树为空, 父节点也为空, 那么就没有前驱节点
        return nil
    }
    
    ///后继节点
    func successor(node: TreeNode<E>?) -> TreeNode<E>? {
        guard let node = node else { return nil }
        
        ///1.查找节点的右子树不为空 [node.right != nil]
        ///1.1.那么后继节点就在查找节点的右子树的迭代左子树中, 直到某个节点的右子树为空 [node.right.left.left...]
        if node.right != nil {
            var p = node.right
            while p?.left != nil {
                p = p?.left
            }
            return p
        }
        
        ///2.查找节点的的右子树为空, 但父节点不为空
        ///2.1.查找节点为父节点的左子节点 [node == node.parent.left]
        ///2.1.1.后继节点为查找节点的父节点, node.parent
        
        ///2.2.查找节点为父节点的右子节点 [node = node.parent.right]
        ///2.2.1.后继节点为查找节点的迭代父节点中, 那么后继节点为 node.parent.parent 直到 该节点的父节点的左子节点为它自己 [node = node.parent.left], 前驱节点即为node.parent
        if node.right == nil, node.parent != nil {
            var p: TreeNode<E>? = node
            if node == node.parent?.left {
                return p?.parent
            } else {
                while p != p?.parent?.left {
                    p = p?.parent
                }
                return p?.parent
            }
        }
        
        ///3.查找节点的右子树为空, 父节点也为空, 那么就没有后继节点
        return nil
    }
}

//MARK: - private
extension BinarySearchTree {
    
    func compare(element1: E?, element2: E?) -> Int {
        if let element1 = element1, let element2 = element2 {
            if element1 > element2 {
                return 1
            } else if element1 < element2 {
                return -1
            } else {
                return 0
            }
        } else {
            return 0
        }
    }
    
    func toString() -> NSMutableString {
        let strM = NSMutableString(string: "\n")
        let prefix = String()
        toString(node: root, strM: strM, prefix: prefix)
        return strM
    }
    
    private func toString(node: TreeNode<E>?, strM: NSMutableString, prefix: String) {
        guard let node = node else { return }
        
        toString(node: node.left, strM: strM, prefix: prefix + "L---")
        strM.append(prefix + node.toString() + "\n")
        toString(node: node.right, strM: strM, prefix: prefix + "R---")
    }
}
