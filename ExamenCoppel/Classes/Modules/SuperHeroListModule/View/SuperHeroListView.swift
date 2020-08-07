//
//  SuperHeroListView.swift
//  ExamenCoppel
//
//  Created by José Luis García on 05/08/20.
//  Copyright © 2020 José Luis García. All rights reserved.
//

import UIKit
import SVProgressHUD

class SuperHeroListView: UIViewController {
    
    // MARK: - Properties
    var searchController: UISearchController!
    let estimateWidth = 160.0
    let cellMarginSize = 16.0
    var presenter:SuperHeroListViewToPresenterProtocol?
    var viewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.backgroundColor = .white
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "bgApp")
        view.insertSubview(backgroundImage, at: 0)
        return view
    }()
    lazy var collectionHeroes: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        collectionView.register(SuperHeroListViewCell.self, forCellWithReuseIdentifier: "SuperHeroListViewCell")
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        refreshControl.attributedTitle = NSAttributedString(string: "Cargando", attributes: attributes)
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.renderStatusBarTransparent()
        setupView()
        setupConstraints()
        self.presenter?.viewDidLoad()
        collectionHeroes.addSubview(refreshControl)
        setupSearchController()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    // MARK: - Actions
    @objc func refresh() {
        presenter?.refresh()
    }
}

extension SuperHeroListView: SuperHeroListPresenterToViewProtocol{
    func onFetchSuperHeroSuccess() {
        self.hideLoading()
        self.collectionHeroes.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    func onFetchSuperHeroFailure() {
        self.hideLoading()
        self.refreshControl.endRefreshing()
    }
    
    func showLoading() {
        showHUD()
    }
    
    func hideLoading() {
        dismissHUD()
    }
}

// MARK: - UI Setup
extension SuperHeroListView {
    func setupView(){
        view.backgroundColor = UIColor.white
        view.addSubview(viewContainer)
        viewContainer.addSubview(collectionHeroes)
    }
    
    func setupConstraints(){
        viewContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        viewContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        viewContainer.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        viewContainer.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true

        collectionHeroes.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: 90).isActive = true
        collectionHeroes.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16).isActive = true
        collectionHeroes.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16).isActive = true
        collectionHeroes.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 8).isActive = true
    }
    
    func setupSearchController(){
        let locationTableView = SuperHeroSearchTable()
        locationTableView.presenter = self.presenter
        searchController = UISearchController(searchResultsController: locationTableView)
        searchController.searchResultsUpdater = locationTableView
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.delegate = locationTableView
        searchController.searchBar.delegate = locationTableView
        
        if #available(iOS 13.0, *) {
            self.searchController.searchBar.searchTextField.backgroundColor = .white
            self.searchController.searchBar.searchTextField.placeholder = "Buscar"
            searchController.searchBar.setValue("Cancelar", forKey: "cancelButtonText")
        } else {
            // Fallback on earlier versions
        }
        self.navigationItem.titleView = self.searchController.searchBar
        definesPresentationContext = true
    }
}

// MARK: - Extensions
extension SuperHeroListView {
    private func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()

        layout.sectionInset = UIEdgeInsets(top: 10,
                                           left: 10,
                                           bottom: 10,
                                           right: 10)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: 150, height: 150)
        
        return layout
    }
}

// MARK: - UICollectionViewDelegate & Data Source
extension SuperHeroListView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuperHeroListViewCell", for: indexPath) as! SuperHeroListViewCell
        
        let myHero = self.presenter?.getHeroAtRow(index: indexPath.row)
        
        cell.labelNombreHero.text = myHero?.name
        cell.labelDescripcionCorta.text = myHero?.biography?.fullName
        cell.labelDescripcionCorta.text! += "\n" + (myHero?.biography?.firstAppearance)!
        cell.labelDescripcionCorta.text! += "\n" + (myHero?.biography?.publisher)!
        cell.imagenHero.image = nil
        
        if let url = URL(string: (myHero?.image?.url)!.URLEncodedString()!) {
            downloadImage(containerImage: cell.imagenHero, from: url)
        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.calculateWidth()
        return CGSize(width: self.view.frame.size.width - 30, height: width)
    }
    
    func calculateWidth() -> CGFloat{
        let estimatedWidth = CGFloat(estimateWidth)
        let cellCount = floor(CGFloat(self.view.frame.size.width) / estimatedWidth)
        let margin = CGFloat(cellMarginSize * 2)
        let width = ((self.view.frame.size.width - CGFloat(cellMarginSize) * (cellCount - 1) - margin) / cellCount) - 16
        return width
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {        
        self.presenter?.didSelectRowAt(index: indexPath.row)
    }
}

class SuperHeroListViewCell: UICollectionViewCell {
    //var nota: Nota?
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setupUI()
    }
    
    // MARK: - Properties
    lazy var roundedBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.7
        view.layer.shadowRadius = 4.0
        return view
    }()
    lazy var viewImagenHero: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.7
        view.layer.shadowRadius = 4.0
        view.backgroundColor = .white
        return view
    }()
    var imagenHero: SemiRoundImageView = {
        let image = SemiRoundImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    var labelNombreHero: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.text = ""
        label.textColor = .black
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.4
        label.font = UIFont(name:"Flink-Medium", size: 22)
        return label
    }()
    var labelDescripcionCorta: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.text = ""
        label.textColor = .black
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 0
        label.font = UIFont(name:"Flink-Regular", size: 16)
        return label
    }()
}

// MARK: - UI Setup
extension SuperHeroListViewCell {
    private func setupUI() {
        
        contentView.addSubview(roundedBackgroundView)
        roundedBackgroundView.addSubview(viewImagenHero)
        viewImagenHero.addSubview(imagenHero)
        roundedBackgroundView.addSubview(labelNombreHero)
        roundedBackgroundView.addSubview(labelDescripcionCorta)
        
        NSLayoutConstraint.activate([
            roundedBackgroundView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            roundedBackgroundView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5),
            roundedBackgroundView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 5),
            roundedBackgroundView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -5),
            
            viewImagenHero.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 24),
            viewImagenHero.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -24),
            viewImagenHero.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 24),
            viewImagenHero.widthAnchor.constraint(equalTo: viewImagenHero.heightAnchor),
            
            imagenHero.topAnchor.constraint(equalTo: viewImagenHero.topAnchor, constant: 0),
            imagenHero.bottomAnchor.constraint(equalTo: viewImagenHero.bottomAnchor, constant: 0),
            imagenHero.leftAnchor.constraint(equalTo: viewImagenHero.leftAnchor, constant: 0),
            imagenHero.rightAnchor.constraint(equalTo: viewImagenHero.rightAnchor, constant: 0),
            
            labelNombreHero.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 32),
            labelNombreHero.leftAnchor.constraint(equalTo: viewImagenHero.rightAnchor, constant: 8),
            labelNombreHero.rightAnchor.constraint(equalTo: roundedBackgroundView.rightAnchor, constant: -8),
            labelNombreHero.heightAnchor.constraint(equalToConstant: 27),

            labelDescripcionCorta.topAnchor.constraint(equalTo: labelNombreHero.bottomAnchor, constant: 4),
            labelDescripcionCorta.leftAnchor.constraint(equalTo: viewImagenHero.rightAnchor, constant: 8),
            labelDescripcionCorta.rightAnchor.constraint(equalTo: roundedBackgroundView.rightAnchor, constant: -8),
            labelDescripcionCorta.bottomAnchor.constraint(equalTo: roundedBackgroundView.bottomAnchor, constant: -24)
        ])
    }
}

class SuperHeroSearchTable : UITableViewController {
    var matchingItems:[SuperHero] = []
    var presenter:SuperHeroListViewToPresenterProtocol?
}

extension SuperHeroSearchTable: UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        // No need to update anything if we're being dismissed.
        if !searchController.isActive {
            return
        }

        let searchBarText = searchController.searchBar.text
        matchingItems = self.presenter?.searchHeroesByFilter(filter: searchBarText ?? "") ?? []
        
        if matchingItems.count == 0{
            return
        }
        self.tableView.reloadData()
    }
}

extension SuperHeroSearchTable {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "mapCell")
        let selectedItem = matchingItems[indexPath.row]
        cell.textLabel?.text = selectedItem.name
        return cell
    }
}

extension SuperHeroSearchTable {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter?.showSuperHeroDetailController(myHero: matchingItems[indexPath.row])
        dismiss(animated: true, completion: nil)
    }
}
