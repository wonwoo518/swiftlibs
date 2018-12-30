import UIKit


func quicksortV1<T: Comparable>(_ a: [T]) -> [T] {
    guard a.count > 1 else { return a }
    
    let pivot = a[a.count/2]
    let less = a.filter { $0 < pivot }
    let equal = a.filter { $0 == pivot }
    let greater = a.filter { $0 > pivot }
    
    return quicksortV1(less) + equal + quicksortV1(greater)
}

var arr = [111,9,11,10,0,9,5,4]
print(quicksortV1(arr))

