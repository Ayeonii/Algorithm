import Foundation

/*
 * - 합승 택시 요금 : https://programmers.co.kr/learn/courses/30/lessons/72413
 * - 플로이드 와샬의 사용으로 모든 행렬에는 i->j까지의 이동경로 중 최소 요금의 금액이 측정됨.
 */


print(solution(6,4,6,2,[[4, 1, 10], [3, 5, 24], [5, 6, 2], [3, 1, 41], [5, 1, 24], [4, 6, 50], [2, 4, 66], [2, 3, 22], [1, 6, 25]]))

func solution(_ n:Int, _ s:Int, _ a:Int, _ b:Int, _ fares:[[Int]]) -> Int {
    
    let INF = 100000 * n //모든 fareMap이 INF일 경우를 고려.
    var fareMap : [[Int]] = Array(repeating: Array(repeating: INF, count: n+1), count: n+1)
    
    fareMap.enumerated().forEach {
        fareMap[$0.offset][$0.offset] = 0
    }
   
    fares.forEach {
        let i = $0[0]
        let j = $0[1]
        let k = $0[2]
        
        fareMap[i][j] = k
        fareMap[j][i] = k
    }

  
    for k in 1...n {
        for i in 1...n {
            for j in 1...n {
                if fareMap[i][j] > fareMap[i][k] + fareMap[k][j] {
                    fareMap[i][j] = fareMap[i][k] + fareMap[k][j]
                }
            }
        }
    }
    
    var minFare = fareMap[s][a] + fareMap[s][b]
    
    for middle in 1...n {
        let commonFare = fareMap[s][middle] + fareMap[middle][a] + fareMap[middle][b]
        minFare = min(minFare, commonFare)
    }
    
    return minFare
}
