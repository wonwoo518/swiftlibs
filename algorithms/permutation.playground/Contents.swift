//Created by wonwoo.lee
import UIKit

func permutation<T:Comparable>(arr:[T], exceptArr:[T]){
    
    if arr.count == exceptArr.count {
        print(exceptArr)
        return
    }

    //1개 원소만빼서 출력
    var myArr = arr.filter{
        return exceptArr.contains($0) == false
    }

    for it in myArr {
        var exceptArrTemp = exceptArr
        exceptArrTemp.append(it)
        permutation(arr: arr, exceptArr: exceptArrTemp)
    }
}




permutation(arr:["a","b","c","d"], exceptArr:[])
permutation(arr:[1,2,3,4], exceptArr:[])
