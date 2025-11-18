import SwiftUI

struct TransactionRow: View {
    let transaction: Transaction

    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.accentColor.opacity(0.12))
                    .frame(width: 44, height: 44)
                Image(systemName: icon)
                    .foregroundStyle(Color.accentColor)
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.title)
                    .font(.headline)
                Text(transaction.subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(amountText)
                    .font(.headline)
                    .foregroundStyle(transaction.isDebit ? .primary : .green)
                Text(transaction.date.formatted(date: .abbreviated, time: .omitted))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }

    private var amountText: String {
        let value = transaction.isDebit ? -transaction.amount : transaction.amount
        return value.formatted(.currency(code: transaction.currency))
    }

    private var icon: String {
        switch transaction.category {
        case .food: return "fork.knife"
        case .transport: return "car.fill"
        case .entertainment: return "gamecontroller"
        case .utilities: return "bolt.fill"
        case .shopping: return "bag.fill"
        case .transfers: return "arrow.left.arrow.right"
        case .salary: return "banknote"
        }
    }
}

#Preview {
    TransactionRow(transaction: Transaction.sampleData().first!)
        .padding()
}
