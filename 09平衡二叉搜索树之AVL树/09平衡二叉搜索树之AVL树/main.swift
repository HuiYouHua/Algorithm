//
//  main.swift
//  09平衡二叉搜索树之AVL树
//
//  Created by 华惠友 on 2020/10/26.
//

import Foundation

func main() {
    
//    let data = [67, 52, 92, 96, 53, 95, 13, 63, 34, 82, 76, 54, 9, 68, 39]
    let data = [11, 6, 4, 8, 15,14,12,16]
    let avl = AVLTree<Int>()
    
    for i in 0..<data.count {
        avl.add(element: data[i])
    }
    
    for i in 0..<data.count {
        avl.remove(element: data[i])
        print(data[i])
//        avl.preorder()
//        print(avl.toString())
        print("-------")
    }
//    avl.preorder()
    
////    if let node = avl.node(element: 67) as? AVLNode<Int> {
////        print(node.balanceFactor())
////    }
//
////    avl.remove(element: 16)
//    avl.remove(element: 9)
////    if let node = avl.node(element: 13) as? AVLNode<Int> {
//    if let node = avl.node(element: 67) as? AVLNode<Int> {
//        print(node.balanceFactor())
//    }
    print(avl.toString())
//    avl.preorder()
    getchar()
}

main()

