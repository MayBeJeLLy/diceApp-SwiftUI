import SwiftUI

struct ContentView: View {
    @State private var diceValue1: Int = 1
    @State private var diceValue2: Int = 1
    @State private var isRolling: Bool = false
    
    var body: some View {
        ZStack {
            // Ekranın sol yarısı
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [.red, .orange]), startPoint: .top, endPoint: .bottom))
                .edgesIgnoringSafeArea(.vertical)
                .frame(maxWidth: .infinity)
            
            // Ekranın sağ yarısı
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom))
                .edgesIgnoringSafeArea(.vertical)
                .frame(maxWidth: .infinity)
            
            VStack {
                Text("Basic Dice Game")
                    .font(.largeTitle)
                    .padding()
                    .textCase(nil)
                    .foregroundColor(.white)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.green, .blue]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .cornerRadius(10)
                    .padding()
                
                HStack {
                    Image(systemName: "die.face.\(diceValue1).fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                        .padding()
                        .rotationEffect(Angle(degrees: isRolling ? 360 : 0))
                        .animation(.linear(duration: 0.5))
                    
                    Image(systemName: "die.face.\(diceValue2).fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                        .padding()
                        .rotationEffect(Angle(degrees: isRolling ? 360 : 0))
                        .animation(.linear(duration: 0.5))
                }
                .padding()
                
                Text("Dice Values: \(diceValue1) and \(diceValue2)")
                    .font(.title)
                    .bold()
                    .padding()
                
                Text("Total: \(diceValue1 + diceValue2)")
                    .bold()
                    .font(.title)
                    .padding()
                
                if (diceValue1 + diceValue2) == 2 {
                    withAnimation(Animation.easeInOut(duration: 0.5).repeatCount(3, autoreverses: true)) {
                        Text("You don't look lucky today, please go home.")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .padding()
                            .scaleEffect(isRolling ? 1.2 : 1.0)
                            .opacity(isRolling ? 0.5 : 1.0)
                            .overlay(
                                Text("You don't look lucky today, please go home.")
                                    .foregroundColor(.white)
                                    .font(.largeTitle)
                                    .padding()
                                    .scaleEffect(isRolling ? 1.2 : 1.0)
                                    .opacity(isRolling ? 0.5 : 1.0)
                                    .blur(radius: isRolling ? 10 : 0)
                            )
                    }
                }
                Button(action: {
                    withAnimation {
                        self.isRolling = true
                        self.rollDice()
                    }
                }) {
                    Text("I TRUST MY LUCK")
                        .padding()
                        .foregroundColor(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.black)
                                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
                        )
                }
                .buttonStyle(ShakingButtonStyle(isShaking: isRolling))
                .disabled(isRolling)
            }
        }
    }
    
    func rollDice() {
        withAnimation(Animation.linear(duration: 0.5).repeatCount(2, autoreverses: false)) {
            diceValue1 = Int.random(in: 1...6)
            diceValue2 = Int.random(in: 1...6)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.isRolling = false
        }
    }
}

struct ShakingButtonStyle: ButtonStyle {
    var isShaking: Bool
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(isShaking ? 1.2 : 1.0)
            .animation(.easeInOut(duration: 0.5))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
