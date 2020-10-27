//
//  TreeNode.swift
//  08二叉树
//
//  Created by 华惠友 on 2020/10/23.
//

import Foundation

class TreeNode<E: Comparable & Equatable> : Comparable {
    static func < (lhs: TreeNode<E>, rhs: TreeNode<E>) -> Bool {
        return lhs.element < rhs.element
    }
    
    static func == (lhs: TreeNode<E>, rhs: TreeNode<E>) -> Bool {
        return lhs.element == rhs.element
    }
    
    var element: E
    
    ///左子节点
    var left: TreeNode<E>?
    ///右子节点
    var right: TreeNode<E>?
    ///父节点
    var parent: TreeNode<E>?
    
    init(element: E, parent: TreeNode<E>?) {
        self.element = element
        self.parent = parent
    }
    
    ///是否是叶子节点
    func isLeaf() -> Bool {
        return left == nil && right == nil
    }
    
    ///是否有两个子树
    func hasTwoChildren() -> Bool {
        return left != nil && right != nil
    }
    
    ///是否有左子树节点
    func isLeftChild() -> Bool {
        if parent != nil, self == parent?.left {
            return true
        }
        return false
    }
    
    ///是否有右子树节点
    func isRightChild() -> Bool {
        if parent != nil, self == parent?.right {
            return true
        }
        return false
    }
    
    ///返回兄弟节点
    func sibling() -> TreeNode<E>? {
        if isLeftChild() {
            return parent?.right
        }
        if isRightChild() {
            return parent?.left
        }
        return nil
    }
    
    func toString() -> String {
        return String(describing: element)
    }
}
