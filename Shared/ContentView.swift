import SwiftUI

struct ContentView: View {
    @State private var login = ""
    @State private var senha = ""
    @State private var mostrarSenha = false
    @State private var isLoading = false
    @State private var errorMessage: String?
    @State private var irParaHome = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "#002555")
                    .ignoresSafeArea()

                VStack {
                    VStack(spacing: 10) {
                        Image(systemName: "bus.fill")
                            .font(.system(size: 40))
                            .foregroundColor(Color(hex: "#F5AC00"))

                        Text("ibmec")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                        Text("Bem-vindo(a)")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                        Text("Acesse o aplicativo de transporte Ibmec")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.7))
                    }
                    .padding(.top, 60)

                    Spacer()

                    VStack(spacing: 20) {
                        Capsule()
                            .fill(Color(hex: "#F5AC00"))
                            .frame(width: 40, height: 4)
                            .padding(.top, 10)

                        Text("Entrar")
                            .font(.headline)
                            .foregroundColor(Color(hex: "#002555"))
                            .padding(.bottom, 10)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Login Aluno")
                                .font(.caption)
                                .foregroundColor(.gray)

                            TextField("Digite seu login", text: $login)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled(true)
                        }

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Senha")
                                .font(.caption)
                                .foregroundColor(.gray)

                            HStack {
                                Group {
                                    if mostrarSenha {
                                        TextField("Digite sua senha", text: $senha)
                                    } else {
                                        SecureField("Digite sua senha", text: $senha)
                                    }
                                }

                                Button(action: { mostrarSenha.toggle() }) {
                                    Image(systemName: mostrarSenha ? "eye" : "eye.slash")
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        }

                        if let errorMessage {
                            Text(errorMessage)
                                .font(.caption)
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }

                        Button(action: realizarLogin) {
                            HStack {
                                if isLoading {
                                    ProgressView()
                                        .tint(.white)
                                }

                                Text(isLoading ? "Entrando..." : "Entrar")
                                    .frame(maxWidth: .infinity)
                            }
                            .padding()
                            .background(Color(hex: "#002555"))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .shadow(color: Color(hex: "#002555").opacity(0.3), radius: 8)
                        }
                        .disabled(isLoading)

                        Spacer()

                        Text("Ao entrar, você concorda com nossos Termos de Uso e Política de Privacidade.")
                            .font(.caption2)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 10)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: UIScreen.main.bounds.height * 0.65)
                    .background(Color.white)
                    .cornerRadius(30)
                }
            }
            .navigationDestination(isPresented: $irParaHome) {
                HomeAlunoView(nomeAluno: login)
            }
        }
    }

    private func realizarLogin() {
        errorMessage = nil
        isLoading = true

        Task {
            do {
                let response = try await AuthService.shared.loginAluno(login: login, senha: senha)
                await MainActor.run {
                    isLoading = false
                    if response.sucesso {
                        irParaHome = true
                    } else {
                        errorMessage = response.mensagem
                    }
                }
            } catch {
                await MainActor.run {
                    isLoading = false
                    errorMessage = "Não foi possível conectar ao servidor."
                }
            }
        }
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)

        let r, g, b: UInt64
        (r, g, b) = (
            (int >> 16) & 255,
            (int >> 8) & 255,
            int & 255
        )

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: 1
        )
    }
}
