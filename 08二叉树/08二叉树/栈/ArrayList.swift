//
//  ArrayList.swift
//  02动态数组
//
//  Created by 华惠友 on 2020/10/21.
//

import Foundation

let DEFAULT_CAPACITY = 10
let ELEMENT_NOT_FOUND = -1

protocol ElementDefault {
    associatedtype DefaultType
    var defaultValue: DefaultType { get }
    static var defaultValue: DefaultType { get }
}

class ArrayList<E: Equatable> {
    ///元素的个数
    private var size: Int = 0
    
    ///所有的元素
    private var elements: [E?]
    
    ///初始化
    init(capaticy: Int = DEFAULT_CAPACITY) {
        elements = Array(unsafeUninitializedCapacity: capaticy, initializingWith: { (buffer, count) in
//            for i in 0..<capaticy {
//                buffer[i] = nil
//            }
            count = capaticy
        })
    }
    
    ///容量
    func count() -> Int {
        return size
    }
    
    ///数组是否为空
    func isEmpty() -> Bool {
        return size == 0
    }
    
    ///是否包含某个元素
    func contains(element: E) -> Bool {
        return elements.contains(where: { $0 == element })
    }
    
    ///添加某个元素
    func add(element: E) {
        add(index: size, element: element)
    }
    
    ///返回index位置对应的元素
    func get(index: Int) -> E? {
        if rangeCheck(index: index) == false { return nil }
        return elements[index]
    }
    
    ///设置index位置的元素
    func set(index: Int, element: E) -> E? {
        if rangeCheck(index: index) == false { return nil }
        
        let old = elements[index]
        elements[index] = element
        return old
    }
    
    ///往index位置添加元素
    func add(index: Int, element: E) {
        if rangeCheckForAdd(index: index) == false { return }
        
        ensureCapacity(capacity: size + 1)
        
        if index <= size-1 {
            for i in ((index+1)...size).reversed() {
                elements[i] = elements[i - 1]
            }
        }
        elements[index] = element
        size += 1
    }
    
    ///删除index位置的元素
    func remove(index: Int) -> E? {
        if rangeCheck(index: index) == false { return nil }
        
        let old = elements[index]
        for i in (index+1)..<size {
            elements[i - 1] = elements[i]
        }
        elements.removeLast()
        size -= 1
        return old
    }
    
    ///查看元素的位置
    func indexOf(element: E) -> Int {
        for i in 0..<size {
            if element == elements[i] {
                return i
            }
        }
        return ELEMENT_NOT_FOUND
    }
    
    ///清除所有元素
    func clear() {
        for i in 0..<size {
            elements[i] = nil
        }
        size = 0
    }
    
    func toString() {
        print(elements)
    }
    
    ///扩容
    private func ensureCapacity(capacity: Int) {
        let oldCapacity = elements.count
        if oldCapacity >= capacity { return }
        
        let newCapacity = oldCapacity + oldCapacity >> 1
        var newElements = Array<E?>(unsafeUninitializedCapacity: newCapacity, initializingWith: { (buffer, count) in
            for i in 0..<newCapacity {
                buffer[i] = nil
            }
            count = newCapacity
        })
        
        for i in 0..<size {
            newElements[i] = elements[i]
        }
        elements = newElements
        
        print("\(oldCapacity) 扩容为 \(newCapacity)")
    }
    
    private func rangeCheck(index: Int) -> Bool {
        if index < 0 || index >= size {
            print("index: \(index), size: \(size) 越界了")
            return false
        }
        return true
    }
    
    private func rangeCheckForAdd(index: Int) -> Bool {
        if index < 0 || index > size {
            print("index: \(index), size: \(size) 越界了")
            return false
        }
        return true
    }
}
