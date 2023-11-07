//
//  MissionView.swift
//  Moonshot
//
//  Created by Philip Janzel Paradeza on 2023-11-04.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission
    let crew: [CrewMember]
    var body: some View {
        ScrollView{
            VStack{
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .padding(.top)
                Text(mission.formattedLaunchDate)
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.5))
                VStack(alignment: .leading){
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.lightBackground)
                        .padding(.vertical)
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    Text(mission.description)
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.lightBackground)
                        .padding(.vertical)
                    Text("Crew")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    ScrollView(.horizontal,showsIndicators: false){
                        HStack{
                            ForEach(crew, id: \.role) {
                                crewMember in
                                NavigationLink{
                                    AstronautView(astronaut: crewMember.astronaut)
                                } label: {
                                    HStack{
                                        Image(crewMember.astronaut.id)
                                            .resizable()
                                            .frame(width: 104, height: 72)
                                            .clipShape(Capsule())
                                            .overlay(Capsule()
                                                .strokeBorder(.white, lineWidth: 1)
                                            )
                                        VStack(alignment: .leading){
                                            Text(crewMember.astronaut.name)
                                                .foregroundStyle(.white)
                                                .font(.headline)
                                            Text(crewMember.role)
                                                .foregroundStyle(.white.opacity(0.5))
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]){
        self.mission = mission
        
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
}

struct CrewMember {
    let role: String
    let astronaut: Astronaut
}

//struct MissionView_Previews: PreviewProvider {
//    let missions: [Mission] = Bundle.main.decode("missions.json")
//    static var previews: some View {
//        MissionView()
//    }
//}
