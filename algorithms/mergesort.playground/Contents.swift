import UIKit

func mergesort(_ input:Array<Int>)->Array<Int>{
    if input.count == 1{
        return input
    }
    
    let firstCnt:Int = input.count - input.count/2
    let lastCnt:Int = input.count - firstCnt

    let re1 = mergesort(Array<Int>(input.dropFirst(firstCnt)))
    let re2 = mergesort(Array<Int>(input.dropLast(lastCnt)))

    return arrange(re1, re2)
}

func arrange(_ arr1:Array<Int>, _ arr2:Array<Int>)->Array<Int>{
    var arr3:Array<Int> = []
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

print(mergesort([2,1,3,4,8,7,6]))


