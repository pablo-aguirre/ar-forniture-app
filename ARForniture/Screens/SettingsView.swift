//
//  SettingsView.swift
//  ARForniture
//
//  Created by Pablo Aguirre on 05/08/24.
//

import SwiftUI

struct SettingsView: View {
    @Binding var showSettings: Bool
    
    var body: some View {
        NavigationStack {
            SettingsGrid()
                .navigationTitle("Settings")
                .toolbar(content: {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Done") {
                            showSettings.toggle()
                        }.bold()
                    }
                })
        }
    }
}

struct SettingsGrid: View {
    @EnvironmentObject var sessionSettings: SessionSettings
    private var gritItemLayout = [GridItem(.adaptive(minimum: 100, maximum: 100), spacing: 25)]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gritItemLayout, spacing: 25) {
                SettingToggleButton(isOn: $sessionSettings.isPeopleOcclusionEnabled, setting: .peopleOcclusion)
                SettingToggleButton(isOn: $sessionSettings.isObjectsOcclusionEnabled, setting: .objectOcclusion)
                SettingToggleButton(isOn: $sessionSettings.isLidarDebugEnabled, setting: .lidarDebug)
            }
        }
        .padding(.top, 35)
    }
}

enum Setting {
    case peopleOcclusion
    case objectOcclusion
    case lidarDebug
    
    var label: String {
        get {
            switch self {
            case .peopleOcclusion, .objectOcclusion:
                return "Occlusion"
            case .lidarDebug:
                return "Lidar"
            }
        }
    }
    
    var systemIconName: String {
        get {
            return switch self {
            case .peopleOcclusion:
                "person"
            case .objectOcclusion:
                "cube.box.fill"
            case .lidarDebug:
                "light.min"
            }
        }
    }
}

struct SettingToggleButton: View {
    @Binding var isOn: Bool
    let setting: Setting
    
    var body: some View {
        Button(action: {
            isOn.toggle()
        }, label: {
            VStack {
                Image(systemName: setting.systemIconName)
                    .font(.system(size: 35))
                    .foregroundStyle(isOn ? .green : Color(UIColor.secondaryLabel))
                    .buttonStyle(PlainButtonStyle())
                Text(setting.label)
                    .font(.system(size: 17, weight: .medium, design: .default))
                    .foregroundStyle(isOn ? Color(UIColor.label) : Color(UIColor.secondaryLabel))
            }
        })
        .frame(width: 100, height: 100)
        .background(Color(UIColor.secondarySystemFill))
    }
}


