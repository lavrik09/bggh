import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var service: BankingService

    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label("Главная", systemImage: "house.fill")
                }
            TransferView()
                .tabItem {
                    Label("Переводы", systemImage: "arrow.left.arrow.right")
                }
            CardsView()
                .tabItem {
                    Label("Карты", systemImage: "creditcard.fill")
                }
            ProfileView()
                .tabItem {
                    Label("Профиль", systemImage: "person.crop.circle")
                }
        }
        .environmentObject(DashboardViewModel(service: service))
        .environmentObject(TransferViewModel(service: service))
        .environmentObject(PaymentsViewModel(service: service))
        .environmentObject(CardsViewModel(service: service))
        .environmentObject(ProfileViewModel(service: service))
    }
}
