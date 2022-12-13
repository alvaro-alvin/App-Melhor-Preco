//
//  UIViewOferta.swift
//  MelhorPreco
//
//  Created by user on 28/10/22.
//

/*
    Tela onde é mostrada a lista principal e os mercados recomendados para as compras
    dos produtos desta lista, tabém é possivel a partir desta, editar a lista atual
    e acessar todas as listas
*/
import UIKit

class UIViewLists: UIViewController{
    
    // O objeto da lista atual (coreData)
    public var listaAtual: ListaModel?
    // O gerenciador de dados (classe com funções auxiliares)
    let dataManager = DataManager()
    // contexto do coreData
    let managedContext =
      (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    // User Defaults para informações não tão importantes, como lista atual e a flag de primeiro acesso
    let defaults = UserDefaults.standard
    // lista de mercados mocadas obtidas de um .json
    var itemsMercados = listaMercadosLista
    // produtos presentes na lista atual
    lazy var produtos: [ProdutoModel] = []
    
    // botão que leva a tela de gerenciamento de listas
    lazy var buttonListas : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "appBlue")
        button.layer.cornerRadius = 10
        button.setTitle("Gerenciar listas", for: .normal)
        return button
    }()
    // função do botão de gerenciamento de listas
    @objc func goToGerencia(sender: UIButton!) {
        let gerenciaView = ViewGerenciaListas()
        //gerenciaView.nome_lista_atual = listaAtual?.name
        navigationController?.pushViewController(gerenciaView, animated: true)
    }
    
    // ação quando a lista atual for tocada, vai para a edição
    @objc func checkAction(sender : UITapGestureRecognizer) {
        let editorView = UIViewListEditor()
        editorView.listaAtual = self.listaAtual
        navigationController?.pushViewController(editorView, animated: true)
    }
    
    // ao voltar para essa tela as informações da lista precisam ser atulizadas
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listaAtual = dataManager.saveNewLista(Titulo: defaults.string(forKey: "listaAtual")!, context: managedContext)
        self.tituloListaAtual.text = listaAtual!.name
        produtos = dataManager.produtosFrom(lista: listaAtual!, context: managedContext)
        self.tableLista.reloadData()
    }
    
    // view da lista atual
    lazy var viewListaAtual : UIView = {
        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 1, green: 0.98, blue: 0.97, alpha: 1)
        view.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 20
        return view
    }()
    
    // separador utilizado na visualização da lista atual
    lazy var separador : UIView = {
        let separador = UIView()
        separador.backgroundColor = UIColor(named: "AccentColor")
        separador.translatesAutoresizingMaskIntoConstraints = false
        return separador
    }()
    
    // titulo da lista atual
    lazy var tituloListaAtual : UILabel = {
        let titulo = UILabel()
        titulo.translatesAutoresizingMaskIntoConstraints = false
        titulo.font = .boldSystemFont(ofSize: 21)
        return titulo
        
    }()
    // tabela utilziada para mostrar os produtos da lista
    lazy var tableLista : UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.isScrollEnabled = true
        table.delegate = self
        table.dataSource = self
        table.register(TableViewLista.self, forCellReuseIdentifier: TableViewLista.identifier)
        table.showsVerticalScrollIndicator = true
        return table
    }()
    
    // label "Estabelecimentos indicados"
    lazy var Estabelecimentos_indicados : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0.90, green: 0.62, blue: 0.06, alpha: 1.00)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = false
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.text = "Estabelecimentos indicados:"
        return label
    }()
    

    // tabela com os mercados indicados
    lazy var tabelaMercados : UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .white
        table.separatorStyle = .singleLine
        table.isScrollEnabled = true
        table.delegate = self
        table.dataSource = self
        table.register(TableViewMercado.self, forCellReuseIdentifier: TableViewMercado.identifier)
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // caso seja a primeira vez que o usuario abre o app, são carregados para o coreData um conjunto de listas mocadas em um .json e a lista atual é definida como a primeira.
        if(!isKeyPresentInUserDefaults(key: "firstTime") || defaults.bool(forKey: "firstTime") == true){
            let itemsListas = loadJson(filename: "listas")
            dataManager.load2Core(Array: itemsListas!, context: managedContext)
            listaAtual = dataManager.saveNewLista(Titulo: itemsListas![0].nome, context: managedContext)
            defaults.set(itemsListas![0].nome, forKey: "listaAtual")
            defaults.set(false, forKey: "firstTime")
        }
        // caso não seja a lista atual é obtida do coreData
        else{
            listaAtual = dataManager.saveNewLista(Titulo: defaults.string(forKey: "listaAtual")!, context: managedContext)
        }
        // define o título da view
        self.title = "Listas e compras"
        
        // produtos extraidos da lista
        produtos = dataManager.produtosFrom(lista: listaAtual!, context: managedContext)
        
        // titulo da lista configurado
        tituloListaAtual.text = listaAtual?.name
        
        // função de tocar na lista
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
        viewListaAtual.addGestureRecognizer(gesture)
        
        // função definida para o bottão de gerencia de listas
        buttonListas.addTarget(self, action: #selector(goToGerencia), for: .touchUpInside)
        
        
        // adicionando elementos
        self.view.addSubview(buttonListas)
        self.view.addSubview(viewListaAtual)
        self.viewListaAtual.addSubview(separador)
        self.viewListaAtual.addSubview(tituloListaAtual)
        self.viewListaAtual.addSubview(tableLista)
        self.view.addSubview(Estabelecimentos_indicados)
        self.view.addSubview(tabelaMercados)
        
        // configurando elementos
        configButtonListas()
        configListView()
        configSeparador()
        configLabelTitulo()
        configTableLista()
        configLabelIndicados()
        configTableMercado()

        view.backgroundColor = .white
        }

    func configButtonListas(){
        NSLayoutConstraint.activate([
            buttonListas.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            buttonListas.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            buttonListas.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            buttonListas.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configListView(){
        NSLayoutConstraint.activate([
            viewListaAtual.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewListaAtual.topAnchor.constraint(equalTo: buttonListas.bottomAnchor, constant: 10),
            viewListaAtual.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            viewListaAtual.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            viewListaAtual.heightAnchor.constraint(equalToConstant: 240)
        ])
    }
    
    func configSeparador(){
        NSLayoutConstraint.activate([
            separador.leadingAnchor.constraint(equalTo: viewListaAtual.leadingAnchor, constant: 10),
            separador.trailingAnchor.constraint(equalTo: viewListaAtual.trailingAnchor, constant: -10),
            separador.topAnchor.constraint(equalTo: viewListaAtual.topAnchor, constant: 45),
            separador.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func configLabelTitulo(){
        NSLayoutConstraint.activate([
            tituloListaAtual.leadingAnchor.constraint(equalTo: viewListaAtual.leadingAnchor, constant: 20),
            tituloListaAtual.topAnchor.constraint(equalTo: viewListaAtual.topAnchor, constant: 10),
            tituloListaAtual.trailingAnchor.constraint(equalTo: viewListaAtual.trailingAnchor),
            tituloListaAtual.bottomAnchor.constraint(equalTo: separador.topAnchor)
        ])
    }
    
    func configTableLista(){
        NSLayoutConstraint.activate([
            tableLista.topAnchor.constraint(equalTo: separador.bottomAnchor, constant: 10),
            tableLista.bottomAnchor.constraint(equalTo: viewListaAtual.bottomAnchor, constant: -10),
            tableLista.leadingAnchor.constraint(equalTo: viewListaAtual.leadingAnchor, constant: 20),
            tableLista.trailingAnchor.constraint(equalTo: viewListaAtual.trailingAnchor, constant: -20)
        ])
    }
    
    func configLabelIndicados(){
        NSLayoutConstraint.activate([
            Estabelecimentos_indicados.topAnchor.constraint(equalTo: viewListaAtual.bottomAnchor, constant: 20),
            Estabelecimentos_indicados.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            Estabelecimentos_indicados.heightAnchor.constraint(equalToConstant: 40),
            Estabelecimentos_indicados.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20)
        ])
    }
    
    private func configTableMercado() {
        NSLayoutConstraint.activate([
            tabelaMercados.topAnchor.constraint(equalTo: Estabelecimentos_indicados.bottomAnchor, constant: 10),
            tabelaMercados.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tabelaMercados.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tabelaMercados.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    
    }
}
// gerenciamento das listas
extension UIViewLists: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if(tableView == tableLista){
            return 1
        }
        if(tableView == tabelaMercados){
            return 1
        }
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == tableLista){
            return produtos.count
        }
        if(tableView == tabelaMercados){
            return self.itemsMercados.count
        }
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == tableLista){
            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: TableViewLista.identifier,
                    for: indexPath
                    ) as? TableViewLista else {
                return UITableViewCell()}
            cell.labelProduto.text = "• " + produtos[indexPath.row].name!
            print(produtos[indexPath.row].name!)
        cell.selectionStyle = .none
        return cell;
        }
        if(tableView == tabelaMercados){
            guard let cell = tableView.dequeueReusableCell(
                        withIdentifier: TableViewMercado.identifier,
                        for: indexPath
                        ) as? TableViewMercado else {
                    return UITableViewCell()}
                    let mercado = self.itemsMercados[(indexPath.row)]
                    print(mercado)
            cell.imageViewProduto.image  = UIImage(named: mercado.imagem)
            cell.labelNome.text = mercado.nome
            cell.labelPreco.text = "R$" + mercado.preco
            cell.labelPorcentagem.text =  mercado.porcentagem + "%"
            cell.labelAbaixoDaMedia.text = "Abaixo da\nmédia"
            if(indexPath.row == 0){
                cell.labelAbaixoDaMedia.textColor = UIColor(named: "verde_oferta")
                cell.labelPorcentagem.textColor = UIColor(named: "verde_oferta")
            }
            return cell
        }
        return UITableViewCell()
    }
     
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        if(tableView == tableLista){
            return 25
        }
        if(tableView == tabelaMercados){
            return 100
        }
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(tableView == tabelaMercados){
            let detailView = UIViewMercado()
            detailView.mercado = itemsMercados[indexPath.row]
            detailView.listaAtual = self.listaAtual?.name
            navigationController?.pushViewController(detailView, animated: true)
        }
    }
}

func isKeyPresentInUserDefaults(key: String) -> Bool {
    return UserDefaults.standard.object(forKey: key) != nil
}
 





