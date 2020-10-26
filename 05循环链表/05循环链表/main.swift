//
//  main.swift
//  05循环链表
//
//  Created by 华惠友 on 2020/10/22.
//

import Foundation

func main() {
//    singleCircleLinkedListTest()
//    doubleCircleLinkedListTest()
    josephus2()
    
    getchar()
}

func josephus1() {
    let list = SingleCircleLinkedList<Int>()
    for i in 1...8 {
        list.add(element: i)
    }
    print(list.toString())
    
    list.reset()
    while list.isEmpty() == false {
        list.next()
        if let e = list.remove() {
            print(e)
        }
    }
}

func josephus2() {
    let list = DoubleCircleLinkedList<Int>()
    for i in 1...8 {
        list.add(element: i)
    }
    print(list.toString())
    
    list.reset()
    while list.isEmpty() == false {
        list.next()
        list.next()
        if let e = list.remove() {
            print(e)
        }
    }
}

func singleCircleLinkedListTest() {
    let list = SingleCircleLinkedList<Int>()
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
}

func doubleCircleLinkedListTest() {
    let list = DoubleCircleLinkedList<Int>()
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
}

main()

