import Foundation

print(solution(20))
public func solution(_ N : Int) -> Int {
    // write your code in Swift 4.2.1 (Linux)
    var n = N
    var maxCount = 0
    var zeroCount = 0
    var isOnePaseed = false
    
    while n >= 1 {
        let remain = n % 2
        n = n / 2
        
        if remain == 0, isOnePaseed {
            zeroCount += 1
        } else if remain == 1{
            isOnePaseed = true
            if zeroCount > maxCount {
                maxCount = zeroCount
            }
            zeroCount = 0
        }
    }
    
    return maxCount
}
