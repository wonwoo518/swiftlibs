import UIKit

func binarysearch<T:Comparable>(input:inout Array<T>, start:Int, end:Int, searchVal:T)->Int{
    if end - start == 0 {
        return input[start] == searchVal ? start : -1
    }
    
    let leftEnd = (end - start)/2
    let rightStart = end - leftEnd
    let retLeft = binarysearch(input: &input, start: start, end: leftEnd, searchVal: searchVal)
    if retLeft != -1{
        return retLeft
    }
    
    let retRight = binarysearch(input: &input, start: rightStart, end: leftEnd, searchVal: searchVal)
    if retRight != -1{
        return retRight
    }
    
    return -1
}

var arr = [1,9,10,18,20,29,30,113,134] 
