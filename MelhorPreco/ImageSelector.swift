//
//  ImageSelector.swift
//  MelhorPreco
//
//  Created by user on 04/11/22.
//

// source: https://medium.com/mackmobile/acessando-cc6f7d5753c9

import Foundation
import UIKit

class ImageSelector: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //Instância o controle do sistema de imagens
    var selecionador = UIImagePickerController();
    
    //Cria um alerta
    var alerta = UIAlertController(title: "Escolha uma opção", message: nil, preferredStyle: .actionSheet)
    
    //Cria um UIViewController
    var viewController: UIViewController?
    
    //Cria um callback @escaping
    var retornoSelecionador : ((UIImage) -> ())?;
    
    
    //Função principal
    func selecionadorImagem(_ viewController: UIViewController, _ retorno: @escaping ((UIImage) -> ())) {
        
        /* Declara o callback dessa funcao como sendo a variavel externa pickImageCallback,
        isso serve para o retorno dessa funcao estar em outro metodo,
        no caso, apos a escolha da imagem */
        retornoSelecionador = retorno;
        
        //Declara o viewController como o passado como parâmetro, isso serve para as transições de tela.
        self.viewController = viewController;
        
        //Cria uma ação que chama o método "openCamera"
        let camera = UIAlertAction(title: "Camera", style: .default){
            UIAlertAction in
            self.abrirCamera()
        }
        //Cria uma acao que chama o método "abrirGaleria"
        let galeria = UIAlertAction(title: "Galeria", style: .default){
            UIAlertAction in
            self.abrirGaleria()
        }
        
        //Cria uma outra ação
        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel){
            UIAlertAction in
        }
        
        //Declara que o novo delegate do piker são os métodos abaixo
        selecionador.delegate = self
        
        alerta.view.tintColor = UIColor(named: "AccentColor")
        
        // Adiciona ações ao alerta
        alerta.addAction(camera)
        alerta.addAction(galeria)
        alerta.addAction(cancelar)
        
        //Exibe o alerta na tela
        alerta.popoverPresentationController?.sourceView = self.viewController!.view
        viewController.present(alerta, animated: true, completion: nil)
    }
    
    
    //Abre a câmera
    func abrirCamera(){
        //Desfaz o alerta de seleção gerado anteriormente
        alerta.dismiss(animated: true, completion: nil)
        
        //Aqui verificamos se temos a permissão para acessar a câmera
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            //Define o tipo que queremos selecionar como a câmera
            selecionador.sourceType = .camera
            //Vai para a tela da câmera
            self.viewController?.present(selecionador, animated: true, completion: nil)
        } else {
            //Gera alerta se a pessoa não possue câmera no dispositivo ou caso você rode em um simulador.
            let alerta = UIAlertController(title: "Alerta", message: "Você não tem câmera", preferredStyle: .actionSheet)
            alerta.view.tintColor = UIColor(named: "AccentColor")
            //Cria uma outra ação
            let cancelar = UIAlertAction(title: "Cancelar", style: .cancel){
                UIAlertAction in
            }
            //Mostra alerta
            alerta.addAction(cancelar)
            self.viewController?.present(alerta, animated: true, completion: nil)
        }
    }
    
    
    //Abre a Galeria
    func abrirGaleria(){
        //Desfaz o alerta gerado
        alerta.dismiss(animated: true, completion: nil)
        
        //Por default o tipo de abertura do selecionador em cena é a Galeria
        selecionador.sourceType = .photoLibrary
        
        //Vai para a tela da Galeria
        self.viewController?.present(selecionador, animated: true, completion: nil)
    }
    
    
    //Metodo chamado quando a pessoa cancela a escolha
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //Desfaz a tela da Galeria que foi gerada
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    //Metodo chamado quando a pessoa escolhe uma imagem
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //Desfaz a tela da Galeria que foi gerada
        picker.dismiss(animated: true, completion: nil)
        
        //Verifica o arquivo averto é realmente uma imagem
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Esperava-se uma imagem, mas foi dado o seguinte: \(info)")
        }
        
        //Retorna o callback da função principal
        retornoSelecionador?(image)
    }
}
