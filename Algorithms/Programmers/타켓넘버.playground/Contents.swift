import Foundation

/*
 * - 타겟넘버 : https://programmers.co.kr/learn/courses/30/lessons/43165
 */

func solution(_ numbers:[Int], _ target:Int) -> Int {
    return getSum(sum: 0, numbers, target, 0)
}

func getSum(sum : Int, _ numbers : [Int], _ target : Int, _ startIndex : Int) -> Int {
    var wayCount = 0
    
    if startIndex == numbers.count {
        return sum == target ? 1 : 0
    }
    
    wayCount += getSum(sum: sum + numbers[startIndex], numbers, target, startIndex + 1)
    wayCount += getSum(sum: sum - numbers[startIndex], numbers, target, startIndex + 1)
    
    return wayCount
}
