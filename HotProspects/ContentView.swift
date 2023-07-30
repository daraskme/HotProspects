
import SwiftUI

struct ContentView: View {
    @State private var output = ""
    @State private var isLoading = true

    var body: some View {
        VStack {
            if isLoading {
                Text("Loading...") // ローディング中のメッセージ
            } else {
                Text(output) // 実際の結果を表示するメッセージ
            }
        }
        .task {
            await fetchReadings()
            isLoading = false // 非同期処理が終わったらローディング中のメッセージを非表示にする
        }
    }
    
    func fetchReadings() async { //asyncで非同期関数として定義
        isLoading = true
        let fetchTask = Task { () -> String in
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url) //URLから非同期でjsonをDL
            let readings = try JSONDecoder().decode([Double].self, from: data)
            return "Found \(readings.count) readings"
        }
        
        let result = await fetchTask.result //関数の実行結果を代入する
        
        do {
            output = try result.get() //エラーの可能性があるコードをdoに入れる
        } catch {
            output = "Error: \(error.localizedDescription)" //エラーの際の処理内容
        }
        
        isLoading = false
        
//        switch result {
//            case .success(let str):
//                output = str
//            case .failure(let error):
//                output = "Error: \(error.localizedDescription)"
//        }
// do catchとほぼ同じ内容
    }
}

#Preview {
    ContentView()
}
