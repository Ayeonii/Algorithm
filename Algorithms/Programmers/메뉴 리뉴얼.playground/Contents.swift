import UIKit

/*
 * MARK:- 메뉴 리뉴얼 : https://programmers.co.kr/learn/courses/30/lessons/72411
 */

print(solution(["ABCFG", "AC", "CDE", "ACDE", "BCFG", "ACDEH"], [2, 3, 4]))
print(solution(["ABCDE", "AB", "CD", "ADE", "XYZ", "XYZ", "ACD"], [2, 3, 5]))
print(solution(["XYZ", "XWY", "WXA"], [2, 3, 4]))

func solution(_ orders:[String], _ course:[Int]) -> [String] {
    var setMenuList : [String] = []
    
    //각 배열의 String을 하나의 알파벳 배열 변환. (알파벳 정렬 필요.)
    let eachOrders = orders.map{
        $0.sorted(by : <).map({String($0)})
    }
    
    for courseCnt in course {
        var setMenusWithCount : [String : Int] = [:]
        for order in eachOrders {
            let resultArr = combination(origin:order, remainCombineCount: courseCnt, current: 0, combinedArr: [])
            
            //세트메뉴가 주문될 때마다 주문카운트 증가.
            resultArr.forEach {
                let count = setMenusWithCount[$0] ?? 0
                setMenusWithCount.updateValue(count + 1, forKey: $0)
            }
        }
        
        let maxSetMenu = findMaxOrderInSameCourseCount(setMenusWithCount)
        setMenuList.append(contentsOf: maxSetMenu)
    }
    
    return setMenuList.sorted(by : <)
}

//코스 갯수에 해당하는 모든 조합의 수를 뽑아냄.
func combination(origin : [String], remainCombineCount : Int, current index :  Int, combinedArr :[String]) -> [String] {
    var combine = combinedArr
    var combiArr : [String] = []
    
    if remainCombineCount == 0, origin.count == index {
        combiArr.append(combine.joined(separator: ""))
        return combiArr
    } else if origin.count == index {
        return combiArr
    } else {
        combine.append(origin[index])
        combiArr.append(contentsOf : combination(origin: origin, remainCombineCount: remainCombineCount - 1, current: index + 1, combinedArr: combine))
        combiArr.append(contentsOf : combination(origin: origin, remainCombineCount: remainCombineCount, current: index + 1, combinedArr: combinedArr))
    }
    
    return combiArr
}

//가장 많이 주문된 세트들을 뽑아냄.
func findMaxOrderInSameCourseCount(_ setMenusWithCount : [String : Int]) -> [String]{
    var setMenu : [String] = []
    var maxOrder = 0
    
    setMenusWithCount.forEach {
        if $0.value > 1 {
            if $0.value > maxOrder {
                maxOrder = $0.value
                setMenu = [$0.key]
            } else if $0.value == maxOrder {
                setMenu.append($0.key)
            }
        }
    }
    return setMenu
}


