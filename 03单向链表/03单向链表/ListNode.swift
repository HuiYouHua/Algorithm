//
//  ListNode.swift
//  03单向链表
//
//  Created by 华惠友 on 2020/10/22.
//

import Foundation

class ListNode<T>: NSObject {
    
    var element: T
    
    var next: ListNode?
    
    init(element: T, next: ListNode?) {
        self.element = element
        self.next = next
    }
    
    func description() -> NSMutableString {
        let strM = NSMutableString()
        strM.append("[ \(String(describing: element))")
        
        var node = self
        while node.next != nil {
            node = (node.next)!
            strM.append(", " + String(describing: node.element))
        }
        strM.append(" ]")
        return strM
    }
}
