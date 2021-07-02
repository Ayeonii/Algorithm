import Foundation

/*
 * - 문자열 압축 : https://programmers.co.kr/learn/courses/30/lessons/60057
 */

print(solution("fabababab"))
print(solution("abcabcabcabcdededededede"))

func solution(_ s:String) -> Int {
    let willCheck = s.map{ String($0) }
    var result = s
    
    for i in 1...(willCheck.count/2) {
        var checked = willCheck
        var completedStr = ""
        var duplicatedCount = 1
        
        var prevStr = checked[0..<i].joined()
        checked.removeSubrange(0..<i)
        
        while !checked.isEmpty {
           
            if checked.count < i {
                if checked.isEmpty {
                    completedStr = prevStr
                }
                
                let count = duplicatedCount > 1 ? "\(duplicatedCount)" : ""
                completedStr += (prevStr + count + checked.joined())
                checked.removeAll()
            } else {
               
                let nodeStr = checked[0..<i].joined()
                checked.removeSubrange(0..<i)
                if prevStr == nodeStr {
                    duplicatedCount += 1
           
                    if checked.isEmpty {
                        let count = duplicatedCount > 1 ? "\(duplicatedCount)" : ""
                        completedStr += ("\(count)\(nodeStr)")
                    }
                } else {
              
                    let count = duplicatedCount > 1 ? "\(duplicatedCount)" : ""
                    completedStr += ("\(count)\(prevStr)")
                    
                    if checked.isEmpty {
                        completedStr += ("\(count)\(nodeStr)")
                    }
                    duplicatedCount = 1
                }
              
                prevStr = nodeStr
            }
            
        }
        
        if completedStr.isEmpty {
            completedStr = prevStr
        }
       
        print("-===== completedStr : ",completedStr)
        if completedStr.count < result.count {
           
            result = completedStr
            print(result, "result")
        }
        
    }
    
    return result.count
}

