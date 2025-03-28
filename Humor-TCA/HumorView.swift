//
//  HumorView.swift
//  Humor-TCA
//
//  Created by Sucu, Ege on 28.03.2025.
//


import SwiftUI
import Observation

struct HumorView: View {
    @State var viewModel = HumorViewModel(
        randomJokeUseCase: RandomJokeUseCase(repository: DefaultHumorRepository()),
        searchJokeUseCase: SearchJokeUseCase(repository: DefaultHumorRepository()),
        randomMemeUseCase: RandomMemeUseCase(repository: DefaultHumorRepository())
    )
    
    var jokeOfDay: some View {
        Group {
            Text("Joke of the Day")
                .font(.title)
            VStack(alignment: .center) {
                if let joke = viewModel.joke?.joke {
                    Text(joke)
                        .jokeStyle()
                } else {
                    Text("No Joke For you :( ")
                        .multilineTextAlignment(.center)
                }
            }
        }
    }
    
    var memeOfDay: some View {
        Group {
            Text("Meme of the Day")
                .font(.title)
            
            if let meme = viewModel.meme,
               let memeURL = meme.url {
                AsyncImage(url: memeURL) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxHeight: 300)
                            .clipShape(.rect(cornerRadius: 10))
                            .shadow(radius: 4)
                    } else if phase.error != nil {
                        Text("Error loading meme")
                    } else {
                        ProgressView()
                    }
                }
                .padding()
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    jokeOfDay
                    
                    memeOfDay
                    
                    TextField("Enter search query...", text: $viewModel.searchQuery)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Button("Search") {
                        Task {
                            await viewModel.searchJokes()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                    
                    if viewModel.isLoading {
                        ProgressView("Loading...")
                    } else if let error = viewModel.errorMessage {
                        Text("Error: \(error)")
                            .foregroundColor(.red)
                    } else {
                        ForEach(viewModel.jokes) { joke in
                            VStack(alignment: .center) {
                                Text(joke.joke)
                                    .jokeStyle()
                                    .padding()
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Humor API Demo")
        }
        .task(viewModel.loadRandomData)
    }
}

#Preview {
    let mockRepo = MockHumorRepository()
    let viewModel = HumorViewModel(
        randomJokeUseCase: RandomJokeUseCase(repository: mockRepo),
        searchJokeUseCase: SearchJokeUseCase(repository: mockRepo),
        randomMemeUseCase: RandomMemeUseCase(repository: mockRepo)
    )
    HumorView(viewModel: viewModel)
}
