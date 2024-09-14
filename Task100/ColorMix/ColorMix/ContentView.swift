import SwiftUI

struct ContentView: View {
    @State private var color1: Color = .blue
    @State private var color2: Color = .yellow
    @State private var selectedColor1: String = "Blue"
    @State private var selectedColor2: String = "Yellow"
    @State private var mixedColor: Color = .gray
    @State private var isColorPicker1Presented = false
    @State private var isColorPicker2Presented = false
    @State private var mixColorsToggle = false
    
    let colors: [String: Color] = [
        "Blue": .blue,
        "Yellow": .yellow,
        "Green": .green,
        "Red": .red,
        "Orange": .orange
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
                .padding()
            
            VStack {
                Text(selectedColor1)
                    .font(.headline)
                    .padding(.bottom, 5)
                
                Rectangle()
                    .fill(color1)
                    .frame(width: 120, height: 120)
                    .cornerRadius(20)
                    .onTapGesture {
                        isColorPicker1Presented = true
                    }
            }
            
            Text("+")
                .font(.largeTitle)
                .padding()

            
            VStack {
                Text(selectedColor2)
                    .font(.headline)
                    .padding(.bottom, 5)
                
                Rectangle()
                    .fill(color2)
                    .frame(width: 120, height: 120)
                    .cornerRadius(20)
                    .onTapGesture {
                        isColorPicker2Presented = true
                    }
            }

            Text("=")
                .font(.largeTitle)
                .padding()
            
            Rectangle()
                .fill(mixColorsToggle ? mixedColor : .gray)
                .frame(width: 120, height: 120)
                .cornerRadius(20)
                .padding()

            Toggle("", isOn: $mixColorsToggle)
                .padding()
                .onChange(of: mixColorsToggle) { _ in
                    mixColors()
                }

            Spacer()
        }
        .sheet(isPresented: $isColorPicker1Presented) {
            ColorPickerView(selectedColor: $selectedColor1, selectedUIColor: $color1)
        }
        .sheet(isPresented: $isColorPicker2Presented) {
            ColorPickerView(selectedColor: $selectedColor2, selectedUIColor: $color2)
        }
    }
    
    func mixColors() {
        mixedColor = color1.blend(with: color2)
    }
}

struct ColorPickerView: View {
    @Binding var selectedColor: String
    @Binding var selectedUIColor: Color
    
    let colors: [String: Color] = [
        "Blue": .blue,
        "Yellow": .yellow,
        "Green": .green,
        "Red": .red,
        "Orange": .orange
    ]
    
    var body: some View {
        VStack {
            Picker("Select a color", selection: $selectedColor) {
                ForEach(colors.keys.sorted(), id: \.self) { colorName in
                    Text(colorName)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .onChange(of: selectedColor) { newColor in
                selectedUIColor = colors[newColor] ?? .blue
            }
            
            Button("Confirm") {
                UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true, completion: nil)
            }
            .padding()
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
