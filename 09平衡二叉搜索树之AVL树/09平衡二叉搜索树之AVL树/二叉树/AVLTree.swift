//
//  BST.swift
//  09平衡二叉搜索树之AVL树
//
//  Created by 华惠友 on 2020/10/26.
//

import Cocoa

///AVL树
class AVLTree<E: Comparable>: BinarySearchTree<E> {
    
    override func createNode(element: E, parent: TreeNode<E>?) -> TreeNode<E> {
        return AVLNode(element: element, parent: parent)
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
            
            ///删除节点后的处理
            afterRemove(node: node)
            return
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
            }        ///删除节点后的处理
            afterRemove(node: node)
        }
    }
}

///MARK: - 平衡二叉树
extension AVLTree {
    ///添加后平衡二叉树
    ///可能会导致所有祖先节点都失衡
    func afterAdd(node: TreeNode<E>?) {
        guard let node = node as? AVLNode<E> else { return }
        
        while node.parent != nil {
            if isBalanced(node: node) {
                ///更新高度
                updateHeight(node: node)
            } else {
                ///恢复平衡
                rebalance2(grand: node)
                ///整棵树恢复平衡 只要让高度最低的失衡节点恢复平衡，整棵树就恢复平衡，仅需O（1）次调整
                break
            }
        }
    }
    
    ///删除节点后平衡二叉树
    ///可能会导致父节点或者祖先节点失衡，只有一个节点会失衡
    //TODO: 有问题
    func afterRemove(node: TreeNode<E>?) {
         var node = node as? AVLNode<E>
        node = node?.parent as? AVLNode<E>
        while node != nil {
            if let node = node {
                if isBalanced(node: node) {
                    ///更新高度
                    updateHeight(node: node)
                } else {
                    ///恢复平衡 恢复平衡后，可能会导致更高层的祖先节点失衡，最多需要O（logn）次调整
                    rebalance2(grand: node)
                }
            }
            node = node?.parent as? AVLNode<E>
        }
        
    }
}

///MARK: - 恢复平衡
extension AVLTree {
    func rebalance(grand: AVLNode<E>) {
        let parent = grand.tallerChild()
        let node = parent?.tallerChild()
        
        if parent?.isLeftChild() == true { ///L
            if node?.isLeftChild() == true { ///LL
                rotateRight(grand: grand)
            } else { ///LR
                rotateLeft(grand: parent)
                rotateRight(grand: grand)
            }
        } else { ///R
            if node?.isLeftChild() == true { ///RL
                rotateRight(grand: parent)
                rotateLeft(grand: grand)
            } else { ///RR
                rotateLeft(grand: grand)
            }
        }
    }
    
    func rebalance2(grand: AVLNode<E>) {
        let parent = grand.tallerChild()
        let node = parent?.tallerChild()
        
        if parent?.isLeftChild() == true { ///L
            if node?.isLeftChild() == true { ///LL
                rotate(r: grand, a: node?.left, b: node, c: node?.right, d: parent, e: parent?.right, f: grand, g: grand.right)
            } else { ///LR
                rotate(r: grand, a: parent?.left, b: parent, c: node?.left, d: node, e: node?.right, f: grand, g: grand.right)
            }
        } else { ///R
            if node?.isLeftChild() == true { ///RL
                rotate(r: grand, a: grand.left, b: grand, c: node?.left, d: node, e: node?.right, f: parent, g: parent?.right)
            } else { ///RR
                rotate(r: grand, a: grand.left, b: grand, c: parent?.right, d: parent, e: node?.left, f: node, g: node?.right)
            }
        }
    }
    
    func rotate(r: TreeNode<E>?,
                a: TreeNode<E>?,
                b: TreeNode<E>?,
                c: TreeNode<E>?,
                d: TreeNode<E>?,
                e: TreeNode<E>?,
                f: TreeNode<E>?,
                g: TreeNode<E>?) {
        
        d?.parent = r?.parent
        
        if r?.isLeftChild() == true {
            r?.parent?.left = d
        } else if r?.isRightChild() == true {
            r?.parent?.right = d
        } else {
            root = d
        }
        
        b?.left = a
        if a != nil {
            a?.parent = b
        }
        b?.right = c
        if c != nil {
            c?.parent = b
        }
        
        f?.left = e
        if e != nil {
            e?.parent = b
        }
        
        f?.left = g
        if g != nil {
            g?.parent = b
        }
        d?.left = b
        d?.right = f
        b?.parent = d
        f?.parent = d
        
        updateHeight(node: b as? AVLNode<E>)
        updateHeight(node: f as? AVLNode<E>)
        updateHeight(node: d as? AVLNode<E>)
    }
    ///是否是平衡树
    func isBalanced(node: AVLNode<E>) -> Bool {
        return abs(node.balanceFactor()) <= 1
    }
    
    ///更新子树高度
    func updateHeight(node: AVLNode<E>?) {
        node?.updateHeight()
    }
}

///MARK: - 旋转
extension AVLTree {
 
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
        
        ///更新高度
        updateHeight(node: grand as? AVLNode<E>)
        updateHeight(node: parent as? AVLNode<E>)
    }
}

















