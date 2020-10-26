//
//  ListNode.swift
//  03单向链表
//
//  Created by 华惠友 on 2020/10/22.
//

import Foundation

class ListNode<T>: NSObject {
    
    var element: T
    
    ///指向的前一个节点
    var prev: ListNode?
    ///指向的后一个节点
    var next: ListNode?
    
    init(element: T, prev: ListNode?, next: ListNode?) {
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
