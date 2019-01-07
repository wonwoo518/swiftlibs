//Created by wonwoo.lee
import UIKit

//simple version
print("simple version permutation")
func permutation<T:Comparable>(arr:[T], proceedArr:[T]){
    
    if arr.count == proceedArr.count {
        print(proceedArr)
        return
    }

    //1개 원소만빼서 출력
    var subArr = arr.filter{
        return proceedArr.contains($0) == false
    }

    for it in subArr {
        var tmp = proceedArr
        tmp.append(it)
        permutation(arr: arr, proceedArr: tmp)
    }
}

permutation(arr:["a","b","c","d"], proceedArr:[])
permutation(arr:[1,2,3,4], proceedArr:[])


//permutation with Heaps's algorithm
print("\n\npermutation with Heaps's algorithm")
func permute<C: Collection>(items: C) -> [[C.Iterator.Element]] {
    var scratch = Array(items) // This is a scratch space for Heap's algorithm
    var result: [[C.Iterator.Element]] = [] // This will accumulate our result
    
    // Heap's algorithm
    func heap(_ n: Int) {
        if n == 1 {
            result.append(scratch)
            return
        }
        
//        print("loop start = \(n)")
        for i in 0..<n-1 {
            heap(n-1)
            let j = (n%2 == 1) ? 0 : i
            print("\(scratch) ,\(j), \(n-1)")
            scratch.swapAt(j, n-1)
            
        }
//        print("loop end = \(n)")
        heap(n-1)
    }
    
    // Let's get started
    heap(scratch.count)
    
    // And return the result we built up
    return result
}

let string = "ABCD"
let perms = permute(items: string.characters) // Get the character permutations
let permStrings = perms.map() { String($0) } // Turn them back into strings
print(permStrings) // output if you like

