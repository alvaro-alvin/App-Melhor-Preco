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
    "imagem": "produto_default",
    "nome": "Produto 1",
    "preco": "10,00",
    "estabelecimento": "Mercado 1",
    "porcentagem": "5.7"
},
{
    "imagem": "produto_default",
    "nome": "Produto 2",
    "preco": "8,45",
    "estabelecimento": "Mercado 3",
    "porcentagem": "4.9"
},
{
    "imagem": "produto_default",
    "nome": "Produto 3",
    "preco": "27,00",
    "estabelecimento": "Mercado 7",
    "porcentagem": "4.7"
},
{
    "imagem": "produto_default",
    "nome": "Produto 4",
    "preco": "8,99",
    "estabelecimento": "Mercado 2",
    "porcentagem": "4.2"
},
{
    "imagem": "produto_default",
    "nome": "Produto 5",
    "preco": "54,30",
    "estabelecimento": "Mercado 1",
    "porcentagem": "3.8"
},
{
    "imagem": "produto_default",
    "nome": "Produto 6",
    "preco": "2,99",
    "estabelecimento": "Mercado 3",
    "porcentagem": "3.2"
},
{
    "imagem": "produto_default",
    "nome": "Produto 7",
    "preco": "12,00",
    "estabelecimento": "Mercado 5",
    "porcentagem": "3.0"
}
]
"""
let ofertasData = ofertas.data(using: .utf8)!
let listaOfertas: [Oferta] = try! JSONDecoder().decode([Oferta].self, from: ofertasData)
