import Foundation

final class CardsViewModel: ObservableObject {
    @Published private(set) var cards: [Card]
    @Published var selectedCard: Card?

    private let service: BankingService

    init(service: BankingService) {
        self.service = service
        self.cards = service.cards
        self.selectedCard = service.cards.first
        service.$cards
            .receive(on: RunLoop.main)
            .assign(to: &$cards)
    }

    func toggleLock() {
        guard let card = selectedCard else { return }
        service.toggleCardLock(card)
        selectedCard = service.cards.first(where: { $0.id == card.id })
    }
}
