import Foundation

/*
 * - 순위 검색 : https://programmers.co.kr/learn/courses/30/lessons/72412
 */

print(solution(["java backend junior pizza 150","python frontend senior chicken 210","python frontend senior chicken 150","cpp backend senior pizza 260","java backend junior chicken 80","python backend senior chicken 50"],
               ["java and backend and junior and pizza 100","python and frontend and senior and chicken 200","cpp and - and senior and pizza 250","- and backend and senior and - 150","- and - and - and chicken 100","- and - and - and - 150"]))

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
