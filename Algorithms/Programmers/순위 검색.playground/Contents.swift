import Foundation

/*
 * - 순위 검색 : https://programmers.co.kr/learn/courses/30/lessons/72412
 */

/*
 *  1 : 지원자가 query형식으로 해당될 수 있는 모든 경우의 수를 구한다.
 *  2 : 해당 경우의 수를 조건을 기준으로 점수들을 합친다. (applicantsInfo)
 *  3 : 지원자의 경우의 수(applicantsInfo)를 오름차순 정렬한다.
 *  4 : 입력받은 각각의 쿼리조건을 key 값으로 해당하는 지원자들의 점수를 가져온다.
 *  5 : 이분 탐색으로 쿼리점수(queryScore)보다 작은 값들의 갯수를 가져온다 (minIndex)
 *  6 : 조건에 맞는 지원자들(applicantsScoreArr)에서 쿼리점수보다 작은 값들의 갯수(minIndex)를 뺀 결과가 쿼리에 해당되는 지원자들의 수이다.
 */

print(solution(["java backend junior pizza 1","python frontend senior chicken 210","python frontend senior chicken 150","cpp backend senior pizza 260","java backend junior chicken 80","python backend senior chicken 50"],
               ["java and backend and junior and - 1","python and frontend and senior and chicken 200","cpp and - and senior and pizza 250","- and backend and senior and - 150","- and - and - and pizza 100","- and - and - and - 150","- and - and - and - 0","- and - and - and - 270"]))


func solution(_ info:[String], _ query:[String]) -> [Int] {
    var applicantsInfo : [String : [Int]] = [:]
    var matchingCountArray : [Int] = []
    
    info.forEach {
        let splitArr = $0.components(separatedBy: " ")

        let langArr : [String] = [splitArr[0], "-"]
        let jobArr : [String] = [splitArr[1], "-"]
        let careerArr : [String] = [splitArr[2], "-"]
        let foodArr : [String] = [splitArr[3], "-"]
        let score : Int = Int(splitArr[4])!

        for lang in langArr {
            for job in jobArr {
                for career in careerArr {
                    for food in foodArr {
                        let key = "\(lang)\(job)\(career)\(food)"

                        if applicantsInfo[key] != nil {
                            applicantsInfo[key]?.append(score)
                        } else {
                            applicantsInfo[key] = [score]
                        }
                    }
                }
            }
        }
    }
    
    applicantsInfo.forEach {
        applicantsInfo[$0.key] = $0.value.sorted()
    }
   
    query.forEach{
        let queryArr = $0.components(separatedBy: " and ").joined().components(separatedBy: " ")
        let condition = queryArr[0]
        let queryScore = Int(queryArr[1]) ?? 0
        let applicantsScoreArr = applicantsInfo[condition]

        if let scoreArr = applicantsScoreArr, queryScore <= scoreArr[scoreArr.count - 1] {
            var minIndex = 0
            var maxIndex = scoreArr.count - 1

            while minIndex <= maxIndex {
                let midIndex = ( minIndex + maxIndex ) / 2
                let midScore = scoreArr[midIndex]

                if midScore < queryScore {
                    minIndex = midIndex + 1
                } else {
                    maxIndex = midIndex - 1
                }
            }
            matchingCountArray.append(scoreArr.count - minIndex)
        } else {
            matchingCountArray.append(0)
        }
    }
    
    return matchingCountArray
}

/*
 정확성은 맞지만, 효율성이 떨어짐.

class InfoType {
    var lang : String?
    var job : String?
    var career : String?
    var food : String?
    var score : Int?
    
    init(lang : String, job : String, career : String, food : String, score : String) {
        self.lang = lang == "-" ? nil : lang
        self.job = job == "-" ? nil : job
        self.career = career == "-" ? nil : career
        self.food = food == "-" ? nil : food
        self.score = score == "-" ? nil : Int(score) ?? 0
    }
    
    func isSame(compare : InfoType) -> Bool {
        
        if let score = self.score, score > compare.score ?? 0 {
            return false
        }
        
        if let lang = self.lang, lang != compare.lang {
            return false
        }
        
        if let job = self.job, job != compare.job {
            return false
        }
        
        if let career = self.career, career != compare.career {
            return false
        }
        
        if let food = self.food, food != compare.food {
            return false
        }
        
        return true
    }
}

func solution(_ info:[String], _ query:[String]) -> [Int] {
    var peopleCount : [Int] = []
    
    query.forEach {
        let querySplit = $0.components(separatedBy: " and ")
        let score = querySplit[3].components(separatedBy : " ")
    
        let queryInfo = InfoType(lang: querySplit[0], job: querySplit[1], career: querySplit[2], food: score[0], score: score[1])
        var matchingCount = 0
        
        info.forEach {
            let infoSplit = $0.components(separatedBy: " ")
            let personInfo = InfoType(lang: infoSplit[0], job: infoSplit[1], career: infoSplit[2], food: infoSplit[3], score: infoSplit[4])
            if queryInfo.isSame(compare: personInfo) {
                matchingCount += 1
            }
        }
        
        peopleCount.append(matchingCount)
    }

    return peopleCount
}
*/
