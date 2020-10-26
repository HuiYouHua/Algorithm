//
//  main.swift
//  07队列
//
//  Created by 华惠友 on 2020/10/23.
//

import Foundation

/**
 也可以使用: 双向链表\循环单向链表\循环双向链表\数组等实现
 头部尾部入队
 头部尾部出队
 */
func main() {
    let queue = Queue<Int>()
    queue.enQueue(element: 1)
    queue.enQueue(element: 2)
    queue.enQueue(element: 3)
    queue.enQueue(element: 4)

    print(queue.front() ?? 0)
    
    while queue.isEmpty() == false {
        print(queue.deQueue() ?? 0)
    }
    
    
    getchar()
}

main()
