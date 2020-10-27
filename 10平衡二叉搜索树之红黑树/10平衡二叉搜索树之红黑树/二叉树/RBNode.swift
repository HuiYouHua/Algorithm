//
//  RBNode.swift
//  10平衡二叉搜索树之红黑树
//
//  Created by 华惠友 on 2020/10/27.
//

import Foundation

enum RBTreeNodeType: Int {
    case red
    case black
}

class RBNode<E: Comparable & Equatable>: TreeNode<E> {
    
    var color: RBTreeNodeType = .red
}
