import Foundation

/*
 * - 오픈채팅방 : https://programmers.co.kr/learn/courses/30/lessons/42888?language=swift
 */

print(solution(["Enter uid1234 Muzi", "Enter uid4567 Prodo","Leave uid1234","Enter uid1234 Prodo","Change uid4567 Ryan"]))

enum MotionType : String {
    case enter = "Enter"
    case leave = "Leave"
    case change = "Change"
}

class UserInfo {
    let motion : MotionType?
    let id : String
    var nickName : String = ""
    
    init(info : String) {
        let splitArr = info.components(separatedBy: " ")
        
        self.motion = MotionType.init(rawValue: splitArr[0])
        self.id = splitArr[1]
        
        if motion != .leave {
            self.nickName = splitArr[2]
        }
    }
}

func solution(_ record:[String]) -> [String] {
    var userDic : [String : String] = [:]
    var resultArr : [String]
    
    
    let userInfo : [UserInfo] = record.map {
        let user = UserInfo(info: $0)
        if user.motion != .leave {
            userDic[user.id] = user.nickName
        }
        
        return user
    }
    

    resultArr = userInfo.filter {
        let motion = $0.motion == .enter || $0.motion == .leave
        let nickNameExist = userDic[$0.id] != nil
        
        return motion && nickNameExist
    }.map {
        switch $0.motion {
        case .enter :
            return"\(userDic[$0.id]!)님이 들어왔습니다."
        case .leave :
            return "\(userDic[$0.id]!)님이 나갔습니다."
        default :
            return ""
        }
    }
    
    return resultArr
}
