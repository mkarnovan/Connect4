import Foundation

public class Board {
    let player1 = 1
    let player2 = 2
    let nobody = 0
    var height, width, winlength: Int
    var board : [[Int]]
    var columnCounts = Array<Int> ()
    
    public init (height: Int, width: Int, winlength: Int) {
        self.height = height
        self.width = width
        self.winlength = winlength
        board = [[Int]](repeating:[Int](repeating:0,count:height), count:width)
        for _ in 1...width {
            columnCounts.append(0)
        }
    }
    
    public func isValidMove(column: Int)->Bool{
        return (columnCounts[column] < height)
    }
    
    public func makeMovePlayer1(column: Int) {
        makeMove(column: column, player: true)
    }
    
    public func makeMovePlayer2(column: Int){
       makeMove(column: column, player: false)
    }
    
    public func makeMove(column: Int, player: Bool){
        if isValidMove(column: column) {
            let sign = player ? player1:player2
            board[column][columnCounts[column]] = sign
            columnCounts[column] += 1
        }
    }
    
    public func undoMove(column: Int, player: Bool)->Bool {
        if(columnCounts[column]>0){
            let sign = player ? player1 : player2
            if(board[column][columnCounts[column]-1] == sign){
                board[column][columnCounts[column]-1] = nobody
                columnCounts[column] -= 1
                return true
            }
        }
        return false
    }
    
    public func getWidth()->Int {
        return width
    }
    
    public func toString()->String {
        var res = ""
        for x in 0..<width {
            res += " " + String(x+1) + " "
        }
        res += "\n"
        for y in stride(from: height-1, to: -1, by: -1) {
            for x in 0..<width {
                if(board[x][y]==player1){
                    res += " X "
                }
                else if(board[x][y]==player2){
                    res += " O "
                }
                else {
                    res += " . "
                }
            }
            res += "\n"
        }
        return res
    }
    
    public func hasWinner()->Bool {
        return (getWinner() != nobody)
    }
    
    public func getWinner()->Int {
        
        for x in 0..<width {
            for y in 0...(height-winlength) {
                var player1Win = true
                var player2Win = true
                for i in 0..<winlength {
                    if (player1Win && board[x][y + i] != player1){
                        player1Win = false
                    }
                    if (player2Win && board[x][y + i] != player2){
                        player2Win = false
                    }
                }
                if(player1Win){
                    return player1
                }
                else if(player2Win){
                    return player2
                }
            }
        }
        
        for y in 0..<height {
            for x in 0...(width-winlength) {
                var player1Win = true
                var player2Win = true
                for i in 0..<winlength {
                    if (player1Win && board[x+i][y] != player1){
                        player1Win = false
                    }
                    if (player2Win && board[x+i][y] != player2){
                        player2Win = false
                    }
                }
                if(player1Win){
                    return player1
                }
                else if(player2Win){
                    return player2
                }
            }
        }
        
        for x in 0...(width-winlength){
            for y in 0...(height-winlength){
                var player1Win = true
                var player2Win = true
                for i in 0..<winlength {
                    if (player1Win && board[x+i][y+i] != player1){
                        player1Win = false
                    }
                    if (player2Win && board[x+i][y+i] != player2){
                        player2Win = false
                    }
                }
                if(player1Win){
                    return player1
                }
                else if(player2Win){
                    return player2
                }
            }
        }
        
        for x in stride(from: width-1, to: winlength-2, by: -1){
            for y in 0...(height-winlength) {
                var player1Win = true
                var player2Win = true
                for i in 0..<winlength {
                    if (player1Win && board[x-i][y+i] != player1){
                        player1Win = false
                    }
                    if (player2Win && board[x-i][y+i] != player2){
                        player2Win = false
                    }
                }
                if(player1Win){
                    return player1
                }
                else if(player2Win){
                    return player2
                }
            }
        }
        
     return nobody
    }
    
    public func player1IsWinner()->Bool {
        return (getWinner() == player1)
    }
    
    public func player2IsWinner()->Bool {
        return (getWinner() == player2)
    }
}
