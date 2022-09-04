//
//  ContentView.swift
//  TicTacToe
//
//  Created by Mukul Bhardwaj on 04/09/22.
//

import SwiftUI

//enum SqaureStatus{
//    case empty
//    case home //X
//    case visitor //O
//
//}
//class Sqaure: ObservableObject{
//    @Published var sqaureStatus : SqaureStatus
//
//    init(status : SqaureStatus ){
//        self.sqaureStatus = status
//    }
//}

//class TicTacToeModel : ObservableObject{
//    @Published var sqaures = [Sqaure] ()
//
//    init (){
//        for _ in 0...8{
//            sqaures.append(Sqaure(status: .empty))
//        }
//    }
//}

//struct SqaureView : View {
//    @ObservedObject var dataSource : Sqaure
//    var body: some View {
//        Button (action: {
//
//        }, label: {
//            Text(self.dataSource.sqaureStatus == .home ?
//                 "X" : self.dataSource.sqaureStatus == .visitor ? "0" : " " )
//            .font(.largeTitle)
//            .bold()
//            .foregroundColor(.black)
//            .frame(width: 70, height: 70, alignment: .center)
//            .background(Color.gray.opacity(0.3).cornerRadius(10))
//            .padding(4)
//        })
//    }
//}

struct ContentView: View {
    @StateObject var ticTacToeModel = TicTacToeModel()
    @State var gameOver : Bool = false
    
    func buttonAction(_ index : Int) {
        _ = self.ticTacToeModel.makeMove(index: index, player: .home)
        self.gameOver = self.ticTacToeModel.gameOver.1
    }
    
    var body: some View {
        VStack {
            Text("Tickity Tac Toe")
                .bold()
                .foregroundColor(Color.black.opacity(0.7))
                .padding(.bottom)
                .font(.title2)
            ForEach(0 ..< ticTacToeModel.squares.count / 3, content: {
                row in
                HStack {
                    ForEach(0 ..< 3, content: {
                        column in
                        let index = row * 3 + column
                        SquareView(dataSource: ticTacToeModel.squares[index], action: {self.buttonAction(index)})
                    })
                }
            })
        }.alert(isPresented: self.$gameOver, content: {
            Alert(title: Text("Game Over"),
                  message: Text(self.ticTacToeModel.gameOver.0 != .empty ? self.ticTacToeModel.gameOver.0 == .home ? "You Win!": "AI Wins!" : "Nobody Wins" ) , dismissButton: Alert.Button.destructive(Text("Ok"), action: {
                    self.ticTacToeModel.resetGame()
                  }))
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
