import SwiftUI

// MARK: - COLORS (HEX)
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)

        let a, r, g, b: UInt64
        switch hex.count {
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }

    static let primaryContainer = Color(hex: "#00204A")
    static let primary = Color(hex: "#000A1F")
    static let secondaryFixed = Color(hex: "#DAE2F9")
    static let surface = Color(hex: "#FAF9FD")
    static let outline = Color(hex: "#747780")
    static let successGreen = Color(hex: "#22C55E")
    static let error = Color(hex: "#BA1A1A")
}

// MARK: - VIEW
struct ContentView: View {
    var body: some View {
        ZStack {
            Color.surface.edgesIgnoringSafeArea(.all)

            VStack(spacing: 0) {
                // HEADER
                HStack {
                    Button(action: {
                        // ação voltar
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.white.opacity(0.1))
                            .clipShape(Circle())
                    }

                    Spacer()

                    Text("Carteirinha Digital")
                        .font(.headline)
                        .bold()
                        .foregroundColor(.white)

                    Spacer()

                    Color.clear
                        .frame(width: 40, height: 40)
                }
                .padding(.horizontal)
                .frame(height: 60)
                .background(Color.primaryContainer)

                ScrollView {
                    VStack(spacing: 22) {
                        Spacer().frame(height: 20)

                        // PERFIL
                        VStack(spacing: 8) {
                            ZStack(alignment: .bottomTrailing) {
                                Image("student")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 130, height: 130)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                                    .shadow(radius: 8)

                                Text("ATIVO")
                                    .font(.caption2)
                                    .bold()
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.successGreen)
                                    .foregroundColor(.white)
                                    .clipShape(Capsule())
                            }

                            Text("Ricardo Almeida")
                                .font(.title2)
                                .bold()
                                .foregroundColor(Color.primaryContainer)

                            Text("Matrícula: 2023081492")
                                .font(.subheadline)
                                .foregroundColor(.gray)

                            Text("Administração")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }

                        // CARTÃO QR
                        VStack(spacing: 16) {
                            Image("qrcode")
                                .resizable()
                                .frame(width: 180, height: 180)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(16)
                                .shadow(radius: 5)

                            Text("VALID UNTIL: 12/2026")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            HStack {
                                Image("ibmec")
                                    .resizable()
                                    .frame(width: 40, height: 20)

                                Rectangle()
                                    .frame(width: 1, height: 12)
                                    .foregroundColor(.gray.opacity(0.4))

                                Text("Ibmec Scholar ID")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding()
                        .background(Color.secondaryFixed)
                        .cornerRadius(24)

                        // BOTÕES
                        VStack(spacing: 12) {
                            Button(action: {}) {
                                HStack {
                                    Image(systemName: "square.and.arrow.up")
                                    Text("Compartilhar")
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.primaryContainer)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                            }

                            Button(action: {}) {
                                HStack {
                                    Image(systemName: "arrow.down.circle")
                                    Text("Baixar Offline")
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(hex: "#D7E2FF"))
                                .foregroundColor(Color.primaryContainer)
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.primaryContainer.opacity(0.1))
                                )
                            }
                        }

                        Spacer().frame(height: 30)

                        Button(action: {}) {
                            HStack {
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                Text("Sair da Conta")
                            }
                            .foregroundColor(.error)
                            .padding(.bottom, 40)
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
        }
    }
}
