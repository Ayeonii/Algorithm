import Foundation

/*
 * - 행렬 테두리 회전하기 : https://programmers.co.kr/learn/courses/30/lessons/77485
 */

print(solution(6,6,[[2,2,5,4],[3,3,6,6],[5,1,6,3]]))

func solution(_ rows:Int, _ columns:Int, _ queries:[[Int]]) -> [Int] {
    var matrix = makeMatrix(rows: rows, columns: columns)
    var result : [Int] = []
    
    queries.forEach {
        let rotateResult = rotate(matrix: matrix, query: $0.map{$0-1})
        matrix = rotateResult.keys.first!
        print("바뀐 result : ", matrix)
        
        if let value = rotateResult[matrix] {
            result.append(value)
        }
    }
   
    return result
}

func makeMatrix(rows : Int, columns : Int) -> [[Int]]{
    var matrix : [[Int]] = Array(repeating: Array(repeating: 0, count: rows), count: columns)
    
    var count = 0
    for (index, element) in matrix.enumerated() {
        matrix[index] = element.map { _ in
            count += 1
            return count
        }
    }
    
    return matrix
}

func rotate(matrix : [[Int]], query : [Int]) -> [[[Int]] : Int] {
    var resultMap = matrix
    
    let dx = [1,0,-1,0]
    let dy = [0,1,0, -1]

    let breakNum = [query[2], query[3], query[0], query[1]]
    var x = query[0]
    var y = query[1]
    
    var minValue = matrix[x][y]
    
    for i in 0..<4 {
        let nx = x + dx[i]
        let ny = y + dy[i]
        
        resultMap[x][y] = resultMap[nx][ny]
        
        if resultMap[x][y] < minValue {
            minValue = resultMap[x][y]
        }
        
        x = nx
        y = ny
        
        if dx[i] != 0 , x == breakNum[i] {
            break
        }
        
        if dy[i] != 0 , y == breakNum[i] {
            break
        }
    }

    return [resultMap : minValue]
}
