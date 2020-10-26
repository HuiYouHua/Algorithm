//
//  LinkedList.swift
//  03单向链表
//
//  Created by 华惠友 on 2020/10/22.
//

import Foundation

class LinkedList<E: Equatable>: List {

    typealias E = E
    
    ///首节点
    var first: ListNode<E>?
    ///尾结点
    var last: ListNode<E>?
    
    var size: Int = 0
    
    ///清除所有元素
    func clear() {
        size = 0
        first = nil
        last = nil
    }
    
    ///根据index获取某个元素
    func get(index: Int) -> E? {
        return node(index: index)?.element
    }
    
    ///设置index位置的元素
    func set(index: Int, element: E) -> E? {
        let oldNode = node(index: index)
        let oldElement = oldNode?.element
        oldNode?.element = element
        return oldElement
    }
    
    ///在index位置添加某个元素
    func add(index: Int, element: E) {
        if rangeCheckForAdd(index: index) == false { return }
        
        if index == 0 {
            first = ListNode(element: element, prev: nil, next: first)
            first?.next?.prev = first
        } else {
            let prevNode = node(index: index-1)
            let nextNode = prevNode?.next
            let node = ListNode(element: element, prev: prevNode, next: nextNode)
            prevNode?.next = node
            nextNode?.prev = node
            
            if nextNode == nil { ///插入最后一个位置
                last = node
            }
        }
        size += 1
    }
    
    ///删除index位置的元素
    func remove(index: Int) -> E? {
        if rangeCheck(index: index) == false { return nil }

//        var deleteNode = node(index: index)
//        if index == 0 {
//            let deleteNode = first
//            deleteNode?.next?.prev = nil
//            first = deleteNode?.next
//            deleteNode?.next = nil
//        } else if index == size - 1 {
//            let deleteNode = last
//            deleteNode?.prev?.next = nil
//            last = deleteNode?.prev
//            deleteNode?.prev = nil
//        } else {
//            let prevNode = deleteNode?.prev
//            let nextNode = deleteNode?.next
//            nextNode?.prev = deleteNode?.prev
//            prevNode?.next = deleteNode?.next
//            deleteNode?.prev = nil
//            deleteNode?.next = nil
//        }
        
        let deleteNode = node(index: index)
        let prev = deleteNode?.prev
        let next = deleteNode?.next
        
        if prev == nil { ///index = 0
            first = next
        } else {
            prev?.next = next
        }
        
        if next == nil { ///index = size - 1
            last = prev
        } else {
            next?.prev = prev
        }
        
        size -= 1
        return deleteNode?.element
    }
    
    ///查看元素的索引
    func indexOf(element: E) -> Int {
        var currentNode = first
        for i in 0..<size {
            if currentNode?.element == element {
                return i
            }
            currentNode = currentNode?.next
        }
        return ELEMENT_NOT_FOUND
    }

    ///获取index位置对应的节点
    func node(index: Int) -> ListNode<E>? {
        if rangeCheck(index: index) == false { return nil }
        
        if index <= size >> 1 {
            var node = first
            for _ in 0..<index {
                node = node?.next
            }
            return node
        } else {
            var node = last
            for _ in ((index+1)..<size).reversed() {
                node = node?.prev
            }
            return node
        }
    }
    
    func toString() -> NSMutableString {
        let strM = NSMutableString()
        strM.append("size = \(size)\n")
        strM.append("[ ")
        var node = first
        for i in 0..<size {
            if i != 0 {
                strM.append(", ")
            }
            if let node = node {
                strM.append(String(describing: node.toString()))
            } else {
                strM.append("null")
            }
            node = node?.next
        }
        strM.append(" ]")
        return strM
    }
}
