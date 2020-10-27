//
//  main.swift
//  10平衡二叉搜索树之红黑树
//
//  Created by 华惠友 on 2020/10/27.
//

import Foundation

func main() {
    let data = [55, 87, 56, 74, 96, 22, 62, 20, 70, 68, 90, 50]
    
    let rb = RBTree<Int>()
    for i in 0..<data.count {
        rb.add(element: data[i])
    }
    
//    rb.preorder()
//    print("-------")
    for i in 0..<data.count {
        rb.remove(element: data[i])
        print(data[i])
        rb.preorder()
        print("-------")
    }
    rb.preorder()
    getchar()
}

main()

