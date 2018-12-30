//Create by wonwoo518. 2018/12/30

import UIKit

func quicksortV2<T:Comparable>(_ input:inout Array<T>, left:Int, right:Int){
    
    if right - left < 1 {
        return
    }
    
    //    let pivot = partition(input: &input, left:left, right:right)    //Lomuto's partition
    let pivot = partitionHoare(input: &input, left:left, right:right) // hoare's partition
    //    let pivot = partitionSimple(input: &input, left:left, right:right) // simple version
    
    quicksortV2(&input, left:left, right: pivot-1)
    quicksortV2(&input, left: pivot+1, right: right)
}

// simple partitioning
func partitionSimple<T:Comparable>(input:inout Array<T>, left:Int, right:Int)->Int{
    var pivot = left
    let pivotVal = input[pivot]
    
    let great = input.filter{
        return $0 > pivotVal
    }
    
    let mid = input.filter{
        return $0 == pivotVal
    }
    
    let less = input.filter{
        return $0 < pivotVal
    }
    
    input = less + mid + great
    pivot = less.count
    return pivot
}

//Hoare's partition
func partitionHoare<T:Comparable>(input:inout Array<T>, left:Int, right:Int)->Int{
    
    var pivot = left
    var low = left
    var high = right + 1
    
    while true {
        
        repeat{ high -= 1 } while (high >= left) && (input[high] > input[pivot]) //뒤에서부터 pivot원소보다 작은 값의 index를 찾는다.
        repeat{ low += 1 } while (low <= right) && (input[low] < input[pivot])   //앞에서부터 pivot원소보다 큰 값의 index를 찾는다.
        
        print("low = \(low), high = \(high) \(input[low]), \(input[high])")
        
        if low < high{
            (input[high], input[low]) = (input[low], input[high])
        }else{
            (input[pivot], input[high]) = (input[high], input[pivot])
            pivot = high
            break
        }
        print(input)
    }
    
    return pivot
}

//Lomuto's partition
func partition<T:Comparable>(input:inout Array<T>, left:Int, right:Int)->Int{
    
    var pivot = right
    var i = left // i는 비교 기준이 되는 원소의 index
    
    for j in left ..< right{
        if input[j] <= input[pivot]{
            (input[i], input[j]) = (input[j], input[i]) // * input[j]는 pivot보다 작음. input[j]를 input[i]와 바꿈으로 input[pivot]보다 작은 값을 앞쪽으로 이동시킨다.
            i += 1                                      // i원소는 pivot보다 작으므로 i값을 증가시켜 그다음 원소부터 비교
        }
    }
    
    (input[i], input[right]) = (input[right], input[i])
    pivot = i
    return pivot
}




var arr = [111,9,11,10,0,9,5,4]

quicksortV2(&arr, left: 0, right: arr.count-1)
print(arr)


func a(){
    var arr:Array<Int> = [1,2]
    var i = 0
    repeat{
        print("!")
        i += 1
    }while false && arr[10] < 1
}

a()

