//
//  AVLNode.swift
//  09平衡二叉搜索树之AVL树
//
//  Created by 华惠友 on 2020/10/26.
//

import Foundation

class AVLNode<E: Comparable & Equatable>: TreeNode<E> {
    ///树的高度
    var height = 0
    
    override init(element: E, parent: TreeNode<E>?) {
        self.height = 1
        super.init(element: element, parent: parent)
    }
    
    ///平衡因子
    func balanceFactor() -> Int {
        let leftHeight = left == nil ? 0 : ((left as? AVLNode)?.height ?? 0)
        let rightHeight = right == nil ? 0 : ((right as? AVLNode)?.height ?? 0)
        return leftHeight - rightHeight
    }
    
    ///更新高度
    func updateHeight() {
        let leftHeight = left == nil ? 0 : ((left as? AVLNode)?.height ?? 0)
        let rightHeight = right == nil ? 0 : ((right as? AVLNode)?.height ?? 0)
        height = 1 + max(leftHeight, rightHeight)
    }
    
    ///返回节点数较多的节点
    func tallerChild() -> AVLNode<E>? {
        let leftHeight = left == nil ? 0 : ((left as? AVLNode)?.height ?? 0)
        let rightHeight = right == nil ? 0 : ((right as? AVLNode)?.height ?? 0)
        
        if leftHeight > rightHeight {
            return left as? AVLNode<E>
        }
        if leftHeight < rightHeight {
            return right as? AVLNode<E>
        }
        return (isLeftChild() ? left : right) as? AVLNode<E>
    }
}
