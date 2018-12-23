import UIKit


//하노이 탑의 포인트
//n개의 디스크를 목적지에 옮기기 위해선 반드시 아래와 같은 순서로 동작
//1. 꼭대기부터 n-1까진 경유지(aux)로 이동 
//2. 맨 아래 디스크는 목적지(to) 로 이동
//3. 꼭대기부터 n-1까지 경유지(aux)에서 목적지(to)로 이동

func hanoi(diskNum n:Int,from: Character,to: Character,by:Character) {
    if n == 1 { // 종료조건 (n = 1 이 문제 범위에서 가장 작은 단위)
        print(" 원반 1 을 \(from) 에서 \(to) 로 이동.")
    }else {
        hanoi(diskNum: n-1, from: from, to: by, by: to) // 알고리즘 #1
        print(" 원반 \(n) 을 \(from) 에서 \(to) 로 이동.")   // 알고리즘 #2
        hanoi(diskNum: n-1, from:by , to: to, by: from) // 알고리즘 #3
    }
}

hanoi(diskNum: 2, from: "a", to: "c", by: "b")


class HanoiV2{
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
    
    init(arr:NSMutableArray) {
        towerFrom.arr = arr
    }

    func run(){
        hanoi(diskNum: towerFrom.arr.count, from: towerFrom, to: towerTo, by: towerAux)
    }
    
    private func hanoi(diskNum n:Int,from: Stack,to: Stack,by:Stack) {
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


//var hanoiV2 = HanoiV2(arr: [4,3,2,1])
//hanoiV2.run()


