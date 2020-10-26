//
//  main.swift
//  02动态数组
//
//  Created by 华惠友 on 2020/10/21.
//

import Foundation

func main() {
    
    let array = ArrayList<Int>(capaticy: 3)
    array.add(element: 1)
    array.add(element: 2)
    array.add(index: 1, element: 3)
    array.add(index: 4, element: 4)
    array.add(index: 2, element: 5)
    array.add(element: 6)
    array.add(element: 7)
    array.add(element: 8)
    array.add(element: 9)
    _ = array.set(index: 7, element: 77)
    print(array.toString())
    print(array.get(index: 4))
    array.remove(index: 7)
    print(array.toString())
    print(array.indexOf(element: 5))
    
    getchar()
}

main()

