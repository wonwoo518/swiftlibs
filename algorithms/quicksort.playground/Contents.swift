import UIKit


func quicksortV1<T: Comparable>(_ a: [T]) -> [T] {
    guard a.count > 1 else { return a }
    
    let pivot = a[a.count/2]
    let less = a.filter { $0 < pivot }
    let equal = a.filter { $0 == pivot }
    let greater = a.filter { $0 > pivot }
    
    return quicksortV1(less) + equal + quicksortV1(greater)
}

func quicksortV2<T:Comparable>(_ input:inout Array<T>, left:Int, right:Int){
    
    if right - left < 1 {
        return
    }
    
    let pivot = partition(input: &input, left:left, right:right)
    
    quicksortV2(&input, left:left, right: pivot-1)
    quicksortV2(&input, left: pivot+1, right: right)
}

func partition<T:Comparable>(input:inout Array<T>, left:Int, right:Int)->Int{

    var pivot = right
    var i = left
    
    for j in left ..< right{
        if input[j] <= input[pivot]{
            (input[i], input[j]) = (input[j], input[i])
            i += 1
        }
    }
    
    (input[i], input[right]) = (input[right], input[i])
    print(input)
    return i
}

//func partition<T:Comparable>(input:inout Array<T>, left:Int, right:Int)->Int{
//    var pivot = left
//    var pivotVal = input[pivot]
//
//    var great = input.filter{
//        return $0 > pivotVal
//    }
//
//    var mid = input.filter{
//        return $0 == pivotVal
//    }
//
//    var less = input.filter{
//        return $0 < pivotVal
//    }
//
//    input = less + mid + great
//    return less.count
//}

var arr = [0,9,9,5,2,4,1,3]

quicksortV2(&arr, left: 0, right: arr.count-1)
print(arr)