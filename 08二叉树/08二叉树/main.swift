//
//  main.swift
//  08二叉树
//
//  Created by 华惠友 on 2020/10/23.
//

import Foundation

func main() {
//    let data = [8, 3, 1, 6, 4, 7, 10, 14, 13]
    let data = [8, 4,2,1,3,6,5,7,15,10,9,12,13]
//    let data = [4,1,2,3,8,7,5,6,10,9,11]

    let tree = BinarySearchTree<Int>()
    for i in 0..<data.count {
        tree.add(element: data[i])
    }
    print(tree.getHeight2())
    print(tree.isCompleteBinaryTree())
//    print(tree.toString())

//    tree.remove(element: 10)
//    tree.remove(element: 8)
//    tree.remove(element: 9)
//        print(tree.toString())
//    ///前驱节点
//    let node1 = tree.node(element: 11)
//    let predecessor = tree.predecessor(node: node1)
//    print(predecessor?.toString() ?? "")
//
//    ///后继节点
//    let node2 = tree.node(element: 2)
//    let successor = tree.successor(node: node2)
//    print(successor?.toString() ?? "")
}

main()
