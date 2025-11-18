import SwiftUI

struct AccountCardView: View {
    let account: Account

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(account.type.rawValue)
                    .font(.callout)
                    .foregroundStyle(.secondary)
                Spacer()
                Image(systemName: "ellipsis")
            }
            Text(account.name)
                .font(.title3.bold())
            Text(account.balance.formatted(.currency(code: account.currency)))
                .font(.title.bold())
            Text(account.accountNumber)
                .font(.caption)
                .foregroundStyle(.secondary)
            if let progress = account.goalProgress {
                ProgressView(value: progress) {
                    Text("Прогресс цели")
                        .font(.caption)
                }
                .progressViewStyle(.linear)
            }
        }
        .padding()
        .frame(width: 260, alignment: .leading)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 24))
        .overlay(alignment: .topLeading) {
            Circle()
                .fill(Color.accentColor.opacity(0.2))
                .frame(width: 120)
                .offset(x: -40, y: -50)
        }
    }
}

#Preview {
    AccountCardView(account: .sample)
        .padding()
        .background(Color(.systemGroupedBackground))
}
