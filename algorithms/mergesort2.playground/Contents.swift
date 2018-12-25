//  Created by wonwoo518 on 2018. 12. 25.

import UIKit

func mergesort<T:Comparable>(_ input:Array<T>)->Array<T>{
    if input.count == 1{
        return input
    }
    
    let firstCnt:Int = input.count - input.count/2
    let lastCnt:Int = input.count - firstCnt
    
    let re1 = mergesort(Array<T>(input.dropFirst(firstCnt)))
    let re2 = mergesort(Array<T>(input.dropLast(lastCnt)))
    
    return arrange(re1, re2)
}

func arrange<T:Comparable>(_ arr1:Array<T>, _ arr2:Array<T>)->Array<T>{
    var arr3:Array<T> = []
    var src1 = arr1
    var src2 = arr2
    while src1.count != 0 && src2.count != 0 {
        if src1[0] > src2[0]{
            arr3.append(src2.removeFirst())
        }else{
            arr3.append(src1.removeFirst())
        }
    }
    
    (src1 + src2).map{
        arr3.append($0)
    }
    
    return arr3
}

mergesort([2,1,3,4,8,7,6])
