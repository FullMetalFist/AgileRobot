//
//  StandupStore.swift
//  AgileRobot
//
//  Created by Michael Vilabrera on 3/14/23.
//

import Foundation
import SwiftUI

class StandupStore: ObservableObject {
    @Published var standups: [DailyScrum] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
            .appendingPathComponent("standups.data")
    }
    
    static func load() async throws -> [DailyScrum] {
        try await withCheckedThrowingContinuation { continuation in
            load { result in
                switch result {
                case .failure(let e):
                    continuation.resume(throwing: e)
                case .success(let standups):
                    continuation.resume(returning: standups)
                }
            }
        }
    }
    
    static func load(completion: @escaping (Result<[DailyScrum], Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let dailyStandups = try JSONDecoder().decode([DailyScrum].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(dailyStandups))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    @discardableResult
    static func save(standups: [DailyScrum]) async throws -> Int {
        try await withCheckedThrowingContinuation { continuation in
            save(standups: standups) { result in
                switch result {
                case .failure(let e):
                    continuation.resume(throwing: e)
                case .success(let standupsSaved):
                    continuation.resume(returning: standupsSaved)
                }
            }
        }
    }
    
    static func save(standups: [DailyScrum], completion: @escaping (Result<Int, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(standups)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(standups.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
