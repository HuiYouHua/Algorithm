//
//  Queue.swift
//  07队列
//
//  Created by 华惠友 on 2020/10/23.
//

import Foundation

protocol QueueProtocol {
    
    associatedtype E
    
    ///元素的数量
    func size() -> Int
    
    ///是否为空
    func isEmpty() -> Bool
    
    ///清空
    func clear()
    
    ///入队
    func enQueue(element: E)
    
    ///出队
    func deQueue() -> E?
    
    ///获取队列的头元素
    func front() -> E?
    
}

class Queue<E: Equatable>: QueueProtocol {
    
    typealias E = E
    
    let list = LinkedList<E>()
    
    ///元素的数量
    func size() -> Int {
        return list.count()
    }
    
    ///是否为空
    func isEmpty() -> Bool {
        return list.isEmpty()
    }
    
    ///清空
    func clear() {
        list.clear()
    }
    
    ///入队
    func enQueue(element: E) {
        list.add(element: element)
    }
    
    ///出队
    func deQueue() -> E? {
        return list.remove(index: 0)
    }
    
    ///获取队列的头元素
    func front() -> E? {
        return list.get(index: 0)
    }
}
