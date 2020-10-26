//
//  DoubleCircleLinkedList.swift
//  05循环链表
//
//  Created by 华惠友 on 2020/10/22.
//

import Foundation

class DoubleListNode<T>: NSObject {
    
    var element: T
    
    ///指向的前一个节点
    var prev: DoubleListNode?
    ///指向的后一个节点
    var next: DoubleListNode?
    
    init(element: T, prev: DoubleListNode?, next: DoubleListNode?) {
        self.element = element
        self.prev = prev
        self.next = next
    }

    func toString() -> NSMutableString {
        let strM = NSMutableString()
        if let prev = prev {
            strM.append(String(describing: prev.element))
        } else {
            strM.append("null")
        }
        strM.append("_")
        strM.append(String(describing: element))
        strM.append("_")
        
        if let next = next {
            strM.append(String(describing: next.element))
        } else {
            strM.append("null")
        }
        return strM
    }
}

class DoubleCircleLinkedList<E: Equatable>: List {
    
    typealias E = E
    
    ///首节点
    var first: DoubleListNode<E>?
    ///尾结点
    var last: DoubleListNode<E>?
    ///当前节点
    var current: DoubleListNode<E>?
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
            first = DoubleListNode(element: element, prev: last, next: first)
            last = first
            last?.prev = first
            last?.next = first
        } else {
            let prevNode = node(index: index-1)
            let nextNode = prevNode?.next
            let node = DoubleListNode(element: element, prev: prevNode, next: nextNode)
            prevNode?.next = node
            nextNode?.prev = node
            
            if nextNode == first { ///插入最后一个位置
                last = node
                last?.next = first
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
        
        if prev == last { ///index = 0
            first = next
        } else {
            prev?.next = next
        }
        
        if next == first { ///index = size - 1
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
    func node(index: Int) -> DoubleListNode<E>? {
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

///双向循环链表约瑟夫问题解决方案
extension DoubleCircleLinkedList {
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
    
    ///删除current指向的节点
    func remove() -> E? {
        let tmpCurrent = current
        current = tmpCurrent?.next
        return removeListNode(deleteNode: tmpCurrent)
    }
    
}
extension DoubleCircleLinkedList {
    ///删除某个节点的下一个节点 [因为单链表无法获取删除节点的下一个节点, 所以这里只能采取删除current节点的下一个节点]
    private func removeListNode(deleteNode: DoubleListNode<E>?) -> E? {
        if size == 1 {
            first = nil
            last = nil
        } else {
            let prevNode = deleteNode?.prev
            prevNode?.next = deleteNode?.next
            prevNode?.next?.prev = prevNode
            if deleteNode == first {
                first = deleteNode?.next
                first?.prev = prevNode
            }
        }
        size -= 1
        return deleteNode?.element
    }
}
