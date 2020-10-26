//
//  main.swift
//  06栈
//
//  Created by 华惠友 on 2020/10/23.
//

import Foundation

func main() {
    let stack = Stack<Int>()
    stack.push(element: 1)
    stack.push(element: 2)
    stack.push(element: 3)
    stack.push(element: 4)

    print(stack.top() ?? 0)
    
    while stack.isEmpty() == false {
        print(stack.pop() ?? 0)
    }
    
    
    getchar()
}

main()
