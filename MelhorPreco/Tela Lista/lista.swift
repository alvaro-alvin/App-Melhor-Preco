//
//  lista.swift
//  MelhorPreco
//
//  Created by user on 28/10/22.
//

import Foundation

struct Lista : Decodable {
    var nome : String
    var produtos: [String]
}


let listas = """
[
{
    "nome": "Lista 1",
    "produtos": [
        "bla1",
        "bla2",
        "bla3",
        "bla4"
        ]
},
{
    "nome": "Lista 2",
    "produtos": [
        "bla1",
        "bla2",
        "bla3",
        "bla4"
        ]
},
{
    "nome": "Lista 3",
    "produtos": [
        "bla1",
        "bla2",
        "bla3",
        "bla4"
        ]
},
{
    "nome": "Lista 4",
    "produtos": [
        "bla1",
        "bla2",
        "bla3",
        "bla4"
        ]
},
{
    "nome": "Lista 5",
    "produtos": [
        "bla1",
        "bla2",
        "bla3",
        "bla4"
        ]
},
{
    "nome": "Lista 6",
    "produtos": [
        "bla1",
        "bla2",
        "bla3",
        "bla4"
        ]
},
{
    "nome": "Lista 7",
    "produtos": [
        "bla1",
        "bla2",
        "bla3",
        "bla4"
        ]
}
]
"""
let listasData = listas.data(using: .utf8)!
let listaListas: [Lista] = try! JSONDecoder().decode([Lista].self, from: listasData)
