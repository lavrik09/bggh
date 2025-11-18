import Foundation
import Combine

final class DashboardViewModel: ObservableObject {
    @Published var searchText = ""
    @Published private(set) var highlightedTransactions: [Transaction] = []
    @Published private(set) var spendingByCategory: [TransactionCategory: Double] = [:]

    private var cancellables = Set<AnyCancellable>()

    init(service: BankingService) {
        service.$transactions
            .sink { [weak self] transactions in
                guard let self else { return }
                self.highlightedTransactions = Array(transactions.prefix(5))
                self.spendingByCategory = Dictionary(grouping: transactions.filter { $0.isDebit }) { $0.category }
                    .mapValues { group in
                        group.reduce(0) { $0 + $1.amount }
                    }
            }
            .store(in: &cancellables)
    }
}
