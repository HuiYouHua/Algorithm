//
//  Stack.swift
//  06栈
//
//  Created by 华惠友 on 2020/10/23.
//

import Foundation

class Stack<E: Equatable> {
    
    private var list = ArrayList<E>()
    
    ///清空
    func clear() {
        list.clear()
    }
    
    ///长度
    func size() -> Int {
        return list.count()
    }
    
    ///是否为空
    func isEmpty() -> Bool {
        return list.isEmpty()
    }
    
    ///入栈
    func push(element: E) {
        list.add(element: element)
    }
    
    ///出栈
    func pop() -> E? {
        return list.remove(index: list.count() - 1)
    }
    
    ///返回顶部元素
    func top() -> E? {
        return list.get(index: list.count() - 1)
    }
    
    
}
