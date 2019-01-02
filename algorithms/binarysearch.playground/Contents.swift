import UIKit

func binarysearch<T:Comparable>(input:inout Array<T>, start:Int, end:Int, searchVal:T)->Int{
    if end - start == 0 {
        return input[start] == searchVal ? start : -1
    }
    
    let center:Int = start + (end - start)/2
    
    if searchVal == input[center]{
        return center
    }
    
    var ret:Int = -1
    let leftStart = start
    let leftEnd = center - 1
    let rightStart = center + 1
    let rightEnd = end
    
    if input[center] > searchVal{
        ret = binarysearch(input: &input, start: leftStart, end: leftEnd, searchVal: searchVal)
    }else{
        ret = binarysearch(input: &input, start: rightStart, end: rightEnd, searchVal: searchVal)
    }
    
    
    return ret
}

var arr = [1,9,10,18,20,29,30,113,134]
var arr2 = ["a","c","f","g","n","q","r","z"]
print(binarysearch(input: &arr2, start: 0, end: arr2.count-1, searchVal: "c"))



