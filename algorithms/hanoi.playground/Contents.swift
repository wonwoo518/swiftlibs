import UIKit


class Hanoi{
    public class Stack{
        var arr:NSMutableArray = []
        var name:String
        init(_ str:String) {
            name = str
        }
        
        func push(_ val:Int){
            arr.add(val)
        }
        
        func pop()->Int{
            let re = arr.lastObject as! Int
            arr.removeLastObject()
            return re
        }
        
        func stat()->String{
            return "\(name)\(arr as! Array<Int>)"
        }
    }
    
    var towerFrom:Stack = Stack("a")
    var towerAux:Stack = Stack("b")
    var towerTo:Stack = Stack("c")

    func hanoi(diskNum n:Int,from: Stack,to: Stack,by:Stack) {
        if n == 1 { // 종료조건 (n = 1 이 문제 범위에서 가장 작은 단위)
            to.push(from.pop())
            print("\(towerFrom.stat()) \(towerAux.stat()) \(towerTo.stat())")
            
        }else {
            hanoi(diskNum: n-1, from: from, to: by, by: to) // a 축에서 c 축으로 원판들 이동시키자!
            to.push(from.pop())
            print("\(towerFrom.stat()) \(towerAux.stat()) \(towerTo.stat())")
            hanoi(diskNum: n-1, from:by , to: to, by: from) // c 에 있던 원판들 b 축에 다시 쌓자!
        }
    }
}





towerFrom.push(4)
towerFrom.push(3)
towerFrom.push(2)
towerFrom.push(1)

hanoi(diskNum: towerFrom.arr.count, from: towerFrom, to: towerTo, by: towerAux)




//func hanoi(diskNum n:Int,from: Character,to: Character,by:Character) {
//    if n == 1 { // 종료조건 (n = 1 이 문제 범위에서 가장 작은 단위)
//        print(" 원반 1 을 \(from) 에서 \(to) 로 이동.")
//    }else {
//        hanoi(diskNum: n-1, from: from, to: by, by: to) // a 축에서 c 축으로 원판들 이동시키자!
//        print(" 원반 \(n) 을 \(from) 에서 \(to) 로 이동.") // 위에 아무것도 없으니 젤 무거운 놈 b 축으로 이동시키자!
//        hanoi(diskNum: n-1, from:by , to: to, by: from) // c 에 있던 원판들 b 축에 다시 쌓자!
//    }
//}
