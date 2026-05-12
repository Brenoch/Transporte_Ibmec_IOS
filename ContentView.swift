import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CarteirinhaDigitalView()
                .tabItem {
                    Label("Carteirinha", systemImage: "person.text.rectangle")
                }

            HomeAlunoView(nomeAluno: "Ricardo")
                .tabItem {
                    Label("Home", systemImage: "house")
                }
        }
    }
}
