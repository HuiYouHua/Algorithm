//
//  SingleCircleLinkedList.swift
//  05循环链表
//
//  Created by 华惠友 on 2020/10/22.
//

import Foundation

class SingleListNode<T>: NSObject {
    
    var element: T
    
    ///指向的后一个节点
    var next: SingleListNode?
    
    init(element: T, next: SingleListNode?) {
        self.element = element
        self.next = next
    }
    func toString() -> NSMutableString {
        let strM = NSMutableString()
        strM.append(String(describing: element))
        if let next = next {
            strM.append("_" + String(describing: next.element))
        } else {
            strM.append("_null")
        }
        return strM
    }
}


class SingleCircleLinkedList<E: Equatable>: List {
    
    typealias E = E
    
    ///首节点
    var first: SingleListNode<E>?
    ///当前节点
    var current: SingleListNode<E>?
    var size: Int = 0
    
    ///清除所有元素
    func clear() {
        size = 0
        first = nil
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
            let newFirst = SingleListNode(element: element, next: first)
            let last = size == 0 ? newFirst : node(index: size - 1)
            last?.next = newFirst
            first = newFirst
        } else {
            let prevNode = node(index: index-1)
            prevNode?.next = SingleListNode(element: element, next: prevNode?.next)
        }
        size += 1
    }
    
    ///删除index位置的元素
    func remove(index: Int) -> E? {
        if rangeCheck(index: index) == false { return nil }
        
        var deleteNode = first
        if index == 0 {
            if size == 1 {
                first = nil
            } else {
                let last = node(index: size - 1)
                first = first?.next
                last?.next = first
                deleteNode?.next = nil
            }
        } else {
            let prev = node(index: index - 1)
            deleteNode = prev?.next
            prev?.next = deleteNode?.next
            deleteNode?.next = nil
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
    func node(index: Int) -> SingleListNode<E>? {
        if rangeCheck(index: index) == false { return nil }
        
        var currentNode = first
        for _ in 0..<index {
            currentNode = currentNode?.next
        }
        return currentNode
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

///单向循环链表约瑟夫问题解决方案
extension SingleCircleLinkedList {
    ///将current 重新指向头结点
    func reset() {
        current = first
    }
    
    ///将current指针向后走一步
    func next() -> E? {
        if current == nil { return nil }
        current = current?.next
        return current?.element
    }
    
    ///删除current指向的节点,删除后让current指向下一个节点
    func remove() -> E? {
        let tmpCurrent = current
        current = tmpCurrent?.next?.next
        return removeListNode(preNode: tmpCurrent)
    }
    
}
extension SingleCircleLinkedList {
    ///删除某个节点的下一个节点 [因为单链表无法获取删除节点的下一个节点, 所以这里只能采取删除current节点的下一个节点]
    private func removeListNode(preNode: SingleListNode<E>?) -> E? {
        var deleteNode = preNode?.next
        if size == 1 {
            deleteNode = first
            first?.next = nil
            first = nil
        } else {
            preNode?.next = deleteNode?.next
            if deleteNode == first {
                first = deleteNode?.next
            }
        }
        size -= 1
        return deleteNode?.element
    }
}
