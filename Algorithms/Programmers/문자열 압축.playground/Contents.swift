import Foundation

/*
 * - 문자열 압축 : https://programmers.co.kr/learn/courses/30/lessons/60057
 */

print(solution("a"))
print(solution("abcabcdede"))
print(solution("abcabcabcabcdededededede"))

func solution(_ s:String) -> Int {
    let willCheck = s.map{ String($0) }
    var result = s
    
    guard willCheck.count > 1 else { return 1 }
    
    for i in 1...(willCheck.count/2) {
        result = makeZipString(willCheck, splitCount: i, result: result)
    }
    
    return result.count
}


func makeZipString(_ willCheck : [String], splitCount : Int, result : String) -> String {
    var resultString = result
    var checked = willCheck
    
    var completedStr = ""
    var duplicatedCount = 1
    var countStr : String {
        return duplicatedCount > 1 ? "\(duplicatedCount)" : ""
    }
    
    var prevStr = checked[0..<splitCount].joined()
    checked.removeSubrange(0..<splitCount)
    
    while !checked.isEmpty {
        if checked.count < splitCount {
            if checked.isEmpty {
                completedStr = prevStr
            }
             
            completedStr += (prevStr + countStr + checked.joined())
            checked.removeAll()
        } else {
            let nodeStr = checked[0..<splitCount].joined()
            checked.removeSubrange(0..<splitCount)
            
            if prevStr == nodeStr {
                duplicatedCount += 1
            } else {
                completedStr += ("\(countStr)\(prevStr)")
                duplicatedCount = 1
            }
            
            if checked.isEmpty {
                completedStr += ("\(countStr)\(nodeStr)")
            }
          
            prevStr = nodeStr
        }
    }
    
    if completedStr.isEmpty {
        completedStr = prevStr
    }
   
    if completedStr.count < resultString.count {
        resultString = completedStr
    }
    
    return resultString
}
