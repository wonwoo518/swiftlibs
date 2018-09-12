import UIKit

class TimerWrapper{
    var timeInterval:Int64 = 0
    var timer:Timer?
    var ticTockEventHandler:((Int64)->Void)?
    var stopEventHandler:(()->Void)?
    
    func startTimer(timeInterval:Int64){
        stopTimer()
        
        self.timeInterval = timeInterval
        
        self.timer = Timer(timeInterval: 1, target: self, selector: #selector(self.ticTock), userInfo: nil, repeats: true)
        RunLoop.current.add(self.timer!, forMode: RunLoopMode.commonModes)
        self.timer?.fire()
    }
    
    func stopTimer(){
        if let timer = self.timer {
            if(timer.isValid){
                RunLoop.current.cancelPerform(#selector(self.ticTock), target: self, argument: nil)
                timer.invalidate()
            }
        }
        stopEventHandler?()
    }
    
    
    
    @objc func ticTock(){
        timeInterval = timeInterval - 1
        if timeInterval == 0{
            stopTimer()
        }
        
        ticTockEventHandler?(timeInterval)
    }
}
