
import SwiftUI

struct ContentView: View {
    
    @StateObject var prospects = Prospects()
    
    var body: some View {
        TabView {
            
            ProspectsView(filter: .none)
                .tabItem {
                    Label("Everyone", systemImage: "person.3")
                }
            
            ProspectsView(filter: .contacted)
                .tabItem {
                    Label("Contected", systemImage: "checkmark.circle")
                }
            
            ProspectsView(filter: .uncontacted)
                .tabItem {
                    Label("UnContacted",systemImage: "questionmark.diamond")
                }
            
            MeView()
                .tabItem {
                    Label("Me",systemImage: "person.crop.square")
                }
        }
        .environmentObject(prospects)
    }
}

#Preview {
    ContentView()
}
