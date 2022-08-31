//
//  oferta.swift
//  MelhorPreco
//
//  Created by user219712 on 8/31/22.
//

import Foundation


struct Oferta : Decodable {
    var imagem : String
    var nome : String
    var preco : String
    var estabelecimento : String
    var porcentagem : String
}


let ofertas = """
[
{
    "imagem": "produto-1",
    "nome": "Produto-1",
    "preco": "10.0",
    "estabelecimento": "Mercado-1",
    "porcentagem": "3.7"
},
{
    "imagem": "produto-2",
    "nome": "Produto-2",
    "preco": "8.4",
    "estabelecimento": "Mercado-3",
    "porcentagem": "5.7"
}
]
"""
let ofertasData = ofertas.data(using: .utf8)!
let listaOfertas: [Oferta] = try! JSONDecoder().decode([Oferta].self, from: ofertasData)
