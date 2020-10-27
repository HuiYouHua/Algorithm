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
            first = ListNode(element: element, next: first)
        } else {
            let prevNode = node(index: index-1)
            prevNode?.next = ListNode(element: element, next: prevNode?.next)
        }
        size += 1
    }
    
    ///删除index位置的元素
    func remove(index: Int) -> E? {
        if rangeCheck(index: index) == false { return nil }
        
        var currentNode = first
        if index == 0 {
            let firstNode = first
            first = first?.next
            firstNode?.next = nil
        } else {
            let prevNode = node(index: index-1)
            currentNode = prevNode?.next
            prevNode?.next = currentNode?.next
            currentNode?.next = nil
        }
        size -= 1
        return currentNode?.element
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
        
        var currentNode = first
        for _ in 0..<index {
            currentNode = currentNode?.next
        }
        return currentNode
    }
    
    func toString() -> NSMutableString {
        let strM = NSMutableString()
        strM.append("size = \(size)\n")
        strM.append(String(describing: first?.description() ?? ""))
        return strM
    }
}

///单向链表的应用
extension LinkedList {
    ///反转一个单向链表 [递归方式]
    func reverseList() {
        print("反转前: \(first?.description() ?? "")")
        let node = reverseList(head: first)
        print("反转后: \(node?.description() ?? "")")
    }
    
    ///反转一个单向链表 [迭代方式]
    func reverseList2() {
        print("反转前: \(first?.description() ?? "")")
        let node = reverseList2(head: first)
        print("反转后: \(node?.description() ?? "")")
    }
    
    /**
     1.T(n)为反转一个链表
     
     2.T(n) 和 T(n-1)的关系为
     1)反转是从头结点开始反转
     2)头结点的值即为第一个元素的值
     3)尾结点的next指向为nil
     4)T(n)代表就是head包括head节点所有的链表
     5)T(n-1)代表是head.next包括head.next节点的所有链表
     6)那么规模小到只剩一个节点的时候,反转操作为返回它自己
     7)当规模小到只剩两个节点的时候,那么反转操作为
    
     3.T(1)表示链表只剩最后一个节点,也就尾结点了 (递归基), 此时返回自己即可
     1)考虑到整个链表可能为空, 那么最后一个节点的判断条件为:
        node = nil || node.next = nil
     */
    func reverseList(head: ListNode<E>?) -> ListNode<E>? {
        if head == nil || head?.next == nil {
            return head
        }
        
        let newHead = reverseList(head: head?.next)
        head?.next?.next = head
        head?.next = nil
        return newHead
    }
    
    /**
        通过迭代遍历, 将原始链表迁移到一个新链表上
        利用两个指针: tmp 和 newHead
        tmp用来引用旧链表, 随着遍历 不断改变指向
        newHead用来引用新链表, 作为新链表的头结点, 随着遍历 不断改变指向
     */
    func reverseList2(head: ListNode<E>?) -> ListNode<E>? {
        var head = head
        if head == nil || head?.next == nil {
            return head
        }
        
        var newHead: ListNode<E>? = nil
        while head != nil {
            let tmp = head?.next
            head?.next = newHead
            newHead = head
            head = tmp
        }
        return newHead
    }
    
    ///是否有环,  快慢指针
    func hasCycle(head: ListNode<E>?) -> Bool {
        if head == nil || head?.next == nil {
            return false
        }
        let head = head
        
        var slow = head
        var fast = head?.next
        while fast != nil, slow != nil {
            slow = slow?.next
            fast = fast?.next?.next
            
            if fast == slow { return true }
        }
        
        return false
    }
}
