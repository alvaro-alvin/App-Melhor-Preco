//
//  lista.swift
//  MelhorPreco
//
//  Created by user on 28/10/22.
//

// Classe de lista que pode ler e escrever jsons

import Foundation

struct Lista : Codable {
    var nome : String
    var produtos: [String]
}


func loadJson(filename fileName: String) -> [Lista]? {
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
        do {
            let listasData = try Data(contentsOf: url)
            let jsonData = try JSONDecoder().decode([Lista].self, from: listasData)
            return jsonData
        } catch {
            print("error:\(error)")
        }
    }
    return nil
}

func writeJson(lista: [Lista], fileName: String) -> Bool{
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json"){
        do{
            let jsonData = try JSONEncoder().encode(lista)
            try jsonData.write(to: url)
            print("Arquivo escrito: \(fileName).json")
        } catch {
            print("Erro ao gravar arquivo")
            return false        }
    }
    return true
}

