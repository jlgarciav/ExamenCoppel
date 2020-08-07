//
//  SuperHeroDetailView.swift
//  ExamenCoppel
//
//  Created by José Luis García on 05/08/20.
//  Copyright © 2020 José Luis García. All rights reserved.
//

import UIKit
import SVProgressHUD

class SuperHeroDetailView: UIViewController {
    var presenter:SuperHeroDetailViewToPresenterProtocol?
    var myHero: SuperHero?
    var viewContainer: UIView = {
        let scrollView = UIView()
        scrollView.backgroundColor = UIColor(hexString: "#e3e3e3")!
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    var viewFotoNota: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var backgroundTop: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    var viewContainerBiografia: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.backgroundColor = UIColor(hexString: "#e3e3e3")!
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    var labelNombreHeroe: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.text = ""
        label.textColor = .black
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 28, weight: .medium)
        return label
    }()
    var labelTituloNombreCompleto: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.text = "Nombre completo"
        label.textColor = .black
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    var labelNombreCompleto: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.text = ""
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    var labelTituloAlterEgo: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.text = "Alter egos"
        label.textColor = .black
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    var labelAlterEgos: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.text = ""
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    var labelTituloLugarNacimiento: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.text = "Lugar de nacimiento"
        label.textColor = .black
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    var labelLugarNacimiento: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.text = ""
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    var labelTituloPrimeraAparicion: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.text = "Primera aparición"
        label.textColor = .black
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    var labelPrimeraAparicion: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.text = ""
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    var labelTituloPublico: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.text = "Editora"
        label.textColor = .black
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    var labelPublico: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.text = ""
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    var labelTituloAfiliacion: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.text = "Afiliación"
        label.textColor = .black
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    var labelAfiliacion: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.text = ""
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()

    private let headerHeight: CGFloat = 280
    private let screenHeight = UIScreen.main.bounds.height - 100

    private var topConstraint: NSLayoutConstraint!
    private var viewFotoTopConstraint: NSLayoutConstraint!
    private var viewFotoHeightConstraint: NSLayoutConstraint!
    private var tablaComentariosMinimumHeightConstraint: NSLayoutConstraint!
    private var tablaComentariosHeightConstraint: CGFloat = 130
    private var viewComentariosHeightConstraint: NSLayoutConstraint!
    private var viewContenidoHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.renderStatusBarTransparent()
        self.presenter?.viewDidLoad()
    }
    
    func setupViews(){
        view.backgroundColor = UIColor(hexString: "#e3e3e3")!
        view.addSubview(viewContainer)
        viewContainer.addSubview(viewFotoNota)
        viewFotoNota.addSubview(backgroundTop)
        viewContainer.addSubview(viewContainerBiografia)
        viewContainerBiografia.addSubview(labelNombreHeroe)
        viewContainerBiografia.addSubview(labelTituloNombreCompleto)
        viewContainerBiografia.addSubview(labelNombreCompleto)
        viewContainerBiografia.addSubview(labelTituloAlterEgo)
        viewContainerBiografia.addSubview(labelAlterEgos)
        viewContainerBiografia.addSubview(labelTituloLugarNacimiento)
        viewContainerBiografia.addSubview(labelLugarNacimiento)
        viewContainerBiografia.addSubview(labelTituloPrimeraAparicion)
        viewContainerBiografia.addSubview(labelPrimeraAparicion)
        viewContainerBiografia.addSubview(labelTituloPublico)
        viewContainerBiografia.addSubview(labelPublico)
        viewContainerBiografia.addSubview(labelTituloAfiliacion)
        viewContainerBiografia.addSubview(labelAfiliacion)
    }
    
    func setupConstraints(){

        NSLayoutConstraint.activate([
            viewContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            viewContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            viewContainer.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            viewContainer.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0)
        ])
        
        viewFotoTopConstraint = viewFotoNota.topAnchor.constraint(equalTo: view.topAnchor)
        viewFotoHeightConstraint = viewFotoNota.heightAnchor.constraint(equalToConstant: headerHeight)

        NSLayoutConstraint.activate([
            viewFotoTopConstraint,
            viewFotoNota.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            viewFotoNota.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            viewFotoHeightConstraint
        ])
        
        NSLayoutConstraint.activate([
            backgroundTop.topAnchor.constraint(equalTo: viewFotoNota.topAnchor, constant: 0),
            backgroundTop.bottomAnchor.constraint(equalTo: viewFotoNota.bottomAnchor, constant: 0),
            backgroundTop.leftAnchor.constraint(equalTo: viewFotoNota.leftAnchor, constant: 0),
            backgroundTop.rightAnchor.constraint(equalTo: viewFotoNota.rightAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            viewContainerBiografia.topAnchor.constraint(equalTo: viewFotoNota.bottomAnchor, constant: 0),
            viewContainerBiografia.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            viewContainerBiografia.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            viewContainerBiografia.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            labelNombreHeroe.topAnchor.constraint(equalTo: viewContainerBiografia.topAnchor, constant: 16),
            labelNombreHeroe.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            labelNombreHeroe.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32)
        ])
        
        NSLayoutConstraint.activate([
            labelTituloNombreCompleto.topAnchor.constraint(equalTo: labelNombreHeroe.bottomAnchor, constant: 24),
            labelTituloNombreCompleto.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            labelTituloNombreCompleto.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32)
        ])
        
        NSLayoutConstraint.activate([
            labelNombreCompleto.topAnchor.constraint(equalTo: labelTituloNombreCompleto.bottomAnchor, constant: 8),
            labelNombreCompleto.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            labelNombreCompleto.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32)
        ])
        
        NSLayoutConstraint.activate([
            labelTituloAlterEgo.topAnchor.constraint(equalTo: labelNombreCompleto.bottomAnchor, constant: 16),
            labelTituloAlterEgo.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            labelTituloAlterEgo.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32)
        ])
        
        NSLayoutConstraint.activate([
            labelAlterEgos.topAnchor.constraint(equalTo: labelTituloAlterEgo.bottomAnchor, constant: 8),
            labelAlterEgos.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            labelAlterEgos.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32)
        ])
        
        NSLayoutConstraint.activate([
            labelTituloLugarNacimiento.topAnchor.constraint(equalTo: labelAlterEgos.bottomAnchor, constant: 16),
            labelTituloLugarNacimiento.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            labelTituloLugarNacimiento.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32)
        ])
        
        NSLayoutConstraint.activate([
            labelLugarNacimiento.topAnchor.constraint(equalTo: labelTituloLugarNacimiento.bottomAnchor, constant: 8),
            labelLugarNacimiento.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            labelLugarNacimiento.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32)
        ])
        
        NSLayoutConstraint.activate([
            labelTituloPrimeraAparicion.topAnchor.constraint(equalTo: labelLugarNacimiento.bottomAnchor, constant: 16),
            labelTituloPrimeraAparicion.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            labelTituloPrimeraAparicion.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32)
        ])
        
        NSLayoutConstraint.activate([
            labelPrimeraAparicion.topAnchor.constraint(equalTo: labelTituloPrimeraAparicion.bottomAnchor, constant: 8),
            labelPrimeraAparicion.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            labelPrimeraAparicion.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32)
        ])
        
        NSLayoutConstraint.activate([
            labelTituloPublico.topAnchor.constraint(equalTo: labelPrimeraAparicion.bottomAnchor, constant: 16),
            labelTituloPublico.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            labelTituloPublico.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32)
        ])
        
        NSLayoutConstraint.activate([
            labelPublico.topAnchor.constraint(equalTo: labelTituloPublico.bottomAnchor, constant: 8),
            labelPublico.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            labelPublico.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32)
        ])
        
        NSLayoutConstraint.activate([
            labelTituloAfiliacion.topAnchor.constraint(equalTo: labelPublico.bottomAnchor, constant: 16),
            labelTituloAfiliacion.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            labelTituloAfiliacion.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32)
        ])
        
        NSLayoutConstraint.activate([
            labelAfiliacion.topAnchor.constraint(equalTo: labelTituloAfiliacion.bottomAnchor, constant: 8),
            labelAfiliacion.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            labelAfiliacion.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            labelAfiliacion.bottomAnchor.constraint(equalTo: viewContainerBiografia.bottomAnchor, constant: -24)
        ])
    }

}

extension SuperHeroDetailView: SuperHeroDetailPresenterToViewProtocol{
    func loadHeroInformation() {
        labelNombreHeroe.text = myHero?.name
        labelNombreCompleto.text = myHero?.biography?.fullName
        labelAlterEgos.text = myHero?.biography?.alterEgos
        labelLugarNacimiento.text = myHero?.biography?.placeOfBirth
        labelPrimeraAparicion.text = myHero?.biography?.firstAppearance
        labelPublico.text = myHero?.biography?.publisher
        labelAfiliacion.text = myHero?.biography?.alignment
    }
    
    func showLoading() {
        self.showHUD()
    }
    
    func hideLoading() {
        self.dismissHUD()
    }
    
    func setupUI() {
        setupViews()
        setupConstraints()
    }
    
    func loadHeroImage(){
        if let url = URL(string: (myHero?.image?.url)!.URLEncodedString()!) {
            downloadImage(containerImage: backgroundTop, from: url)
        }
    }
}

extension SuperHeroDetailView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == viewContainer {
            if scrollView.contentOffset.y < 0.0 {
                viewFotoHeightConstraint?.constant = headerHeight - scrollView.contentOffset.y
            } else {
                let parallaxFactor: CGFloat = 0.25
                let offsetY = scrollView.contentOffset.y * parallaxFactor
                let minOffsetY: CGFloat = 8.0
                let availableOffset = min(offsetY, minOffsetY)
                let contentRectOffsetY = availableOffset / headerHeight
                viewFotoTopConstraint?.constant = view.frame.origin.y
                viewFotoHeightConstraint?.constant = headerHeight - scrollView.contentOffset.y
                backgroundTop.layer.contentsRect = CGRect(x: 0, y: -contentRectOffsetY, width: 1, height: 1)
            }
        }
    }
}
