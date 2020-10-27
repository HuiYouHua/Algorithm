//
//  RBTree.swift
//  10平衡二叉搜索树之红黑树
//
//  Created by 华惠友 on 2020/10/27.
//

import Foundation

class RBTree<E: Comparable>: BinarySearchTree<E> {
    override func createNode(element: E, parent: TreeNode<E>?) -> TreeNode<E> {
        return RBNode(element: element, parent: parent)
    }
    
    ///添加元素到尾部
    @discardableResult
    override func add(element: E) -> TreeNode<E> {
        ///1.是否是根节点, 是创建根节点
        if root == nil {
            root = createNode(element: element, parent: nil)
            size += 1
            
            ///新添加节点后的操作
            afterAdd(node: root)
            return root!
        }
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
        
        ///新添加节点后的操作
        afterAdd(node: root)
        return newNode
    }
    
    ///删除元素为element的节点
    @discardableResult
    override func remove(element: E) -> TreeNode<E>? {
        let removeNode = node(element: element)
        remove(node: removeNode)
        return removeNode
    }
    
    ///删除节点为node的及诶点
    override func remove(node: TreeNode<E>?) {
        guard var node = node else { return }
        
        size -= 1
        
        if node.hasTwoChildren() {
            if let s = successor(node: node) {
                node.element = s.element
                node = s
            }
        }
        
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
        
        //        let replacement = node.left != nil ? node.left : node.right
        //        if let replacement = replacement {
        //            replacement.parent = node.parent
        //            if node.parent == nil {
        //                root = replacement
        //            } else if node == node.parent?.left {
        //                node.parent?.left = replacement
        //            } else {
        //                node.parent?.right = replacement
        //            }
        //        } else if node.parent == nil {
        //            root = nil
        //        } else {
        //            if node == node.parent?.left {
        //                node.parent?.left = nil
        //            } else {
        //                node.parent?.right = nil
        //            }
        //        }
        
        ///删除节点后的处理
        afterRemove(node: node)
    }
}

///MARK: - 红黑树修复
extension RBTree {
    ///添加后平衡二叉树
    ///可能会导致所有祖先节点都失衡
    func afterAdd(node: TreeNode<E>?) {
        let parent = node?.parent
        
        ///添加的是根节点, 或者上溢到达了根节点
        if parent == nil {
            black(node: node)
            return
        }
        
        ///如果父节点是黑色, 直接返回
        if isBlack(node: parent) {
            return
        }
        
        ///叔父节点
        let uncle = parent?.sibling()
        ///祖父节点
        let grand = red(node: parent?.parent)
        
        ///叔父节点是红色 [B树节点上溢]
        if isRed(node: uncle) {
            black(node: parent)
            black(node: uncle)
            
            ///将祖父节点当做是新添加的节点
            afterAdd(node: grand)
            return
        }
        
        ///叔父节点不是红色
        if parent?.isLeftChild() == true{ ///L
            if node?.isLeftChild() == true { ///LL
                black(node: parent)
            } else { //LR
                black(node: node)
                rotateLeft(grand: parent)
            }
            rotateRight(grand: grand)
        } else { ///R
            if node?.isLeftChild() == true { ///RL
                black(node: node)
                rotateRight(grand: parent)
            } else { ///RR
                black(node: parent)
            }
            rotateLeft(grand: grand)
        }
    }
    
    ///删除节点后平衡二叉树
    ///可能会导致父节点或者祖先节点失衡，只有一个节点会失衡
    func afterRemove(node: TreeNode<E>?) {
        guard let node = node else { return }
        ///如果删除的节点是红色
        ///或者用以取代删除节点的子节点是红色
        if isRed(node: node) {
            black(node: node)
            return
        }
        
        let parent = node.parent
        ///删除的是根节点
        if parent == nil {
            return
        }
        
        ///删除的是黑色叶子节点[下溢]
        ///判断删除的node是左还是右
        let left = parent?.left == nil || node.isLeftChild()
        var sibling = left ? parent?.left : parent?.right
        
        if left {
            ///被删除的节点在左边, 兄弟节点在右边
            if isRed(node: sibling) {
                ///兄弟节点是红色
                black(node: sibling)
                red(node: parent)
                rotateLeft(grand: parent)
                
                ///更换兄弟
                sibling = parent?.right
            }
            
            ///兄弟节点必然是黑色
            if isBlack(node: sibling?.left), isBlack(node: sibling?.right) {
                ///兄弟节点没有一个红色节点, 父节点要向下跟兄弟节点合并
                let parentBlack = isBlack(node: parent)
                black(node: parent)
                red(node: sibling)
                
                if parentBlack {
                    afterRemove(node: parent)
                }
            } else {
                ///兄弟节点至少有一个红色节点, 向兄弟节点借元素
                if isBlack(node: sibling?.right) {
                    rotateRight(grand: sibling)
                    sibling = parent?.right
                }
                
                color(node: sibling, color: colorOf(node: parent))
                black(node: sibling?.right)
                black(node: parent)
                rotateLeft(grand: parent)
            }
        } else {
            ///被删除的节点在左边, 兄弟节点在左边
            if isRed(node: sibling) {
                ///兄弟节点是红色
                black(node: sibling)
                red(node: parent)
                rotateRight(grand: parent)
                
                ///更换兄弟
                sibling = parent?.left
            }
            
            ///兄弟节点必然是黑色
            if isBlack(node: sibling?.left), isBlack(node: sibling?.right) {
                ///兄弟节点没有一个红色节点, 父节点要向下跟兄弟节点合并
                let parentBlack = isBlack(node: parent)
                black(node: parent)
                red(node: sibling)
                
                if parentBlack {
                    afterRemove(node: parent)
                }
            } else {
                ///兄弟节点至少有一个红色节点, 向兄弟节点借元素
                ///兄弟节点的左边时黑色,兄弟要先旋转
                if isBlack(node: sibling?.left) {
                    rotateRight(grand: sibling)
                    sibling = parent?.left
                }
                
                color(node: sibling, color: colorOf(node: parent))
                black(node: sibling?.left)
                black(node: parent)
                rotateLeft(grand: parent)
            }
        }
        
        
    }
}

///MARK: - Private
extension RBTree {
    ///设置node的颜色
    @discardableResult
    func color(node: TreeNode<E>?, color: RBTreeNodeType) -> TreeNode<E>? {
        if node == nil {
            return node
        }
        if let node = node as? RBNode {
            node.color = color
        }
        return node
    }
    
    ///设置node为红色
    @discardableResult
    func red(node: TreeNode<E>?) -> TreeNode<E>? {
        return color(node: node, color: .red)
    }
    
    ///设置node为黑色
    @discardableResult
    func black(node: TreeNode<E>?) -> TreeNode<E>? {
        return color(node: node, color: .black)
    }
    
    ///查看node的颜色
    func colorOf(node: TreeNode<E>?) -> RBTreeNodeType {
        return node == nil ? .black : ((node as? RBNode)?.color ?? .red)
    }
    
    ///查看node是否为黑色
    func isBlack(node: TreeNode<E>?) -> Bool {
        return colorOf(node: node) == .black
    }
    
    ///查看node是否为红色
    func isRed(node: TreeNode<E>?) -> Bool {
        return colorOf(node: node) == .red
    }
}

///MARK: - 旋转
extension RBTree {
 
    ///左旋转: grand 爷爷节点
    func rotateLeft(grand: TreeNode<E>?) {
        guard let grand = grand else { return }
        
        let parent = grand.right
        let child = parent?.left
        grand.right = child
        parent?.left = grand
        afterRotate(grand: grand, parent: parent, child: child)
    }
    
    ///右旋转: grand 爷爷节点
    func rotateRight(grand: TreeNode<E>?) {
        guard let grand = grand else { return }
        
        let parent = grand.left
        let child = parent?.right
        grand.left = child
        parent?.right = grand
        afterRotate(grand: grand, parent: parent , child: child)
    }
    
    ///更新父亲爷爷指向关系
    func afterRotate(grand: TreeNode<E>, parent: TreeNode<E>?, child: TreeNode<E>?) {
        ///让parent称为子树的根节点
        parent?.parent = grand.parent
        
        if ((parent?.isLeftChild()) != nil) {
            grand.parent?.left = parent
        } else if grand.isRightChild() {
            grand.parent?.right = parent
        } else {
            ///grand是root节点
            root = grand
        }
        
        ///更新child的parent
        if let child = child {
            child.parent = grand
        }
        
        ///更新grand的parent
        grand.parent = parent
    }
}




