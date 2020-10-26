//
//  main.swift
//  04双向链表
//
//  Created by 华惠友 on 2020/10/22.
//

import Foundation

func main() {
    
    let list = LinkedList<Int>()
    list.add(element: 10)
    list.add(element: 20)
    list.add(element: 30)
    list.add(element: 40)
    print(list.toString())
    
    list.add(index: 0, element: 50)
    list.add(index: 2, element: 60)
    list.add(index: list.size, element: 70)
    print(list.toString())
    
    list.remove(index: 0)
    list.remove(index: 2)
    list.remove(index: list.size - 1)
    print(list.toString())
    
    print(list.indexOf(element: 40))
    print(list.indexOf(element: 20))
    print(list.contains(element: 30))
    print(list.get(index: 0))
    print(list.get(index: 1))
    print(list.get(index: list.size-1))
    print(list.toString())
    getchar()
}

main()


