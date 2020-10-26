//
//  List.swift
//  03单向链表
//
//  Created by 华惠友 on 2020/10/22.
//

import Foundation

let ELEMENT_NOT_FOUND = -1

protocol List {
    associatedtype E
    
    ///元素数量
    var size: Int { set get }
    
    ///清除所有元素
    func clear()
    
    ///元素的数量
    func count() -> Int
    
    ///是否为空
    func isEmpty() -> Bool
    
    ///是否包含某个元素
    func contains(element: E) -> Bool
    
    ///添加某个元素
    func add(element: E)
    
    ///根据index获取某个元素
    func get(index: Int) -> E?
    
    ///设置index位置的元素
    func set(index: Int, element: E) -> E?
    
    ///在index位置添加某个元素
    func add(index: Int, element: E)
    
    ///删除index位置的元素
    func remove(index: Int) -> E?
    
    ///查看元素的索引
    func indexOf(element: E) -> Int
}

extension List {
    ///元素的数量
    func count() -> Int {
        return size
    }
    
    ///是否为空
    func isEmpty() -> Bool {
        return size == 0
    }
    
    ///是否包含某个元素
    func contains(element: E) -> Bool {
        return self.indexOf(element: element) != ELEMENT_NOT_FOUND
    }
    
    ///添加某个元素
    func add(element: E) {
        add(index: size, element: element)
    }
    
    func rangeCheck(index: Int) -> Bool {
        if index < 0 || index >= size {
            print("index: \(index), size: \(size) 越界了")
            return false
        }
        return true
    }
    
    func rangeCheckForAdd(index: Int) -> Bool {
        if index < 0 || index > size {
            print("index: \(index), size: \(size) 越界了")
            return false
        }
        return true
    }
}

