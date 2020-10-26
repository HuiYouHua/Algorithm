//
//  main.swift
//  01复杂度
//
//  Created by 华惠友 on 2020/10/20.
//

import Foundation

func main() {
    ///斐波那契数列
    let fabs1 = fab1(n: 35)
    print(fabs1)
    
    let fabs2 = fab2(n: 35)
    print(fabs2)
    
    let fabs3 = fab3(n: 35)
    print(fabs3)
    getchar()
}

///O(n^2)
func fab1(n: Int) -> Int {
    if n <= 1 { return 1 }
    return fab1(n: n - 1) + fab1(n: n - 2)
}

///O(n)
func fab2(n: Int) -> Int {
    if n <= 1 { return 1 }
    
    var first = 0
    var second = 1
    var sum = 0
    for _ in 0..<n {
        sum = first + second
        first = second
        second = sum
    }
    return second
}

///O(n), 空间复杂度: 比上述少用一个变量
func fab3(n: Int) -> Int {
    if n <= 1 { return 1 }
    
    var first = 0
    var second = 1
    for _ in 0..<n {
        second = first + second
        first = second - first
    }
    
    return second
}

main()

/**
0 1
1 1
1 2
2 3
3 5
5 8
8 13
 */
