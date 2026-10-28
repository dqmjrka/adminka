import SwiftUI

struct PrankItemModel: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let color: Color
    let action: () -> Void
}

struct PranksView: View {
    @EnvironmentObject var tvManager: TvManager
    
    var body: some View {
        ScrollView {
            VStack(spacing: 14) {
                // Active Prank Banner (if any)
                if let active = tvManager.activePrank {
                    HStack(spacing: 10) {
                        ProgressView()
                            .tint(Theme.statusRed)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Выполняется розыгрыш:")
                                .font(.system(size: 11))
                                .foregroundColor(Theme.textSecondary)
                            Text(active)
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(Theme.statusRed)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            tvManager.stopAllPranks()
                        }) {
                            Text("Стоп")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Theme.statusRed)
                                .cornerRadius(8)
                        }
                    }
                    .padding(12)
                    .background(Theme.statusRed.opacity(0.15))
                    .cornerRadius(14)
                    .overlay(RoundedRectangle(cornerRadius: 14).stroke(Theme.statusRed.opacity(0.4), lineWidth: 1))
                }
                
                HStack {
                    Text("Выберите пранк:")
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .foregroundColor(Theme.textSecondary)
                    Spacer()
                }
                
                // 2-Column Grid
                LazyVGrid(columns: [GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10)], spacing: 10) {
                    PrankCardItem(
                        title: "🔥 Ошибка перегрева",
                        desc: "Выводит экран критического перегрева",
                        color: Theme.accentOrange,
                        action: { tvManager.prankOverheat() }
                    )
                    
                    PrankCardItem(
                        title: "⚡ Стробоскоп 5 сек",
                        desc: "Мерцание экраном с авто-восстановлением",
                        color: Color(hex: "#FDCB6E"),
                        action: { tvManager.prankStrobe() }
                    )
                    
                    PrankCardItem(
                        title: "🔌 Микро-глюк",
                        desc: "Погасить на 1.2 сек и включить обратно",
                        color: Theme.accentGlow,
                        action: { tvManager.prankGlitch() }
                    )
                    
                    PrankCardItem(
                        title: "📺 Вечное кабельное",
                        desc: "Бесконечно переключает на LiveTV",
                        color: Theme.primaryPurple,
                        action: { tvManager.prankCableLoop() }
                    )
                    
                    PrankCardItem(
                        title: "🔇 Фантомный Mute",
                        desc: "Глушит звук на 3.5 сек и возвращает",
                        color: Theme.accentPink,
                        action: { tvManager.prankPhantomMute() }
                    )
                    
                    PrankCardItem(
                        title: "🌊 Горки звука",
                        desc: "Разгон громкости до 36 и в ноль",
                        color: Theme.accentBlue,
                        action: { tvManager.prankSoundWave() }
                    )
                    
                    PrankCardItem(
                        title: "📉 Сползание звука",
                        desc: "Тихо убавляет громкость на 5 делений",
                        color: Color(hex: "#A29BFE"),
                        action: { tvManager.prankVolumeCreep() }
                    )
                    
                    PrankCardItem(
                        title: "⏸ Полтергейст паузы",
                        desc: "Жмет паузу каждые 2.5 сек",
                        color: Color(hex: "#FD79A8"),
                        action: { tvManager.prankPoltergeist() }
                    )
                }
                
                Spacer().frame(height: 10)
                
                // Big Emergency Stop Button
                Button(action: {
                    tvManager.stopAllPranks()
                }) {
                    HStack(spacing: 8) {
                        Image(systemName: "stop.circle.fill")
                            .font(.system(size: 20, weight: .bold))
                        Text("🚨 ⛔ СТОП ВСЕ ПРАНКИ")
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .background(Theme.statusRed)
                    .cornerRadius(16)
                    .shadow(color: Theme.statusRed.opacity(0.5), radius: 10, y: 3)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
        }
    }
}

struct PrankCardItem: View {
    let title: String
    let desc: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.system(size: 13, weight: .bold, design: .rounded))
                    .foregroundColor(color)
                    .lineLimit(1)
                
                Text(desc)
                    .font(.system(size: 11))
                    .foregroundColor(Theme.textSecondary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                
                Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 82)
            .padding(12)
            .cyberCard()
        }
    }
}
