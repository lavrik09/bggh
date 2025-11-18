import SwiftUI

struct CardsView: View {
    @EnvironmentObject private var viewModel: CardsViewModel

    var body: some View {
        NavigationStack {
            List(selection: $viewModel.selectedCard) {
                ForEach(viewModel.cards) { card in
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text(card.brand)
                                .font(.headline)
                            Spacer()
                            Text(card.type.rawValue)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        Text(card.number)
                            .font(.title3.monospaced())
                        Text("Баланс: \(card.balance.formatted(.currency(code: card.currency)))")
                        if let limit = card.limit {
                            Text("Лимит: \(limit.formatted(.currency(code: card.currency)))")
                                .font(.caption)
                        }
                        if card.isLocked {
                            Label("Карта заблокирована", systemImage: "lock.fill")
                                .font(.caption)
                                .foregroundStyle(.red)
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationTitle("Карты")
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button("Блокировка") { viewModel.toggleLock() }
                        .disabled(viewModel.selectedCard == nil)
                    Spacer()
                    Button("Новая карта") {}
                }
            }
        }
    }
}

#Preview {
    CardsView()
        .environmentObject(CardsViewModel(service: BankingService()))
}
