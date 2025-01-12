//
//  CountriesViewController.swift
//  CountriesTraveller
//
//  Created by Steew on 20.06.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation

class CountriesViewController: UIViewController {
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var countriesTableView: UITableView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredCountries = Countries()
    private var countries = Countries()
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        prepareLogoutButton()
        prepareTableView()
        prepareSearchController()
        fetchCountries()
        prepareCameraButton()
    }
    
    func prepareCameraButton() {
        cameraButton.setTitle(kCameraButtonTitle, for: .normal)
        cameraButton.setTitleColor(UIColor.black, for: .normal)
        cameraButton.layer.cornerRadius = 0.5 * logoutButton.frame.size.width
        cameraButton.clipsToBounds = true
        cameraButton.backgroundColor = UIColor.lightText
        view.bringSubviewToFront(cameraButton)
        
        cameraButton.addTarget(self, action: #selector(onTapCameraButton), for: .touchUpInside)
    }
    
    @objc func onTapCameraButton() {
        onPhotoAction()
    }
    
    
    func setBackground() {
        let backgroundImageView = UIImageView()
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        backgroundImageView.image = UIImage(named: "background")
        view.sendSubviewToBack(backgroundImageView)
        activityIndicator.isHidden = true
    }
    
    func prepareSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = kSearchPlaceholder
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func prepareTableView() {
        countriesTableView.register(UINib(nibName: "CountryCell", bundle: nil), forCellReuseIdentifier: "CountryCell")
        countriesTableView.delegate = self
        countriesTableView.dataSource = self
        countriesTableView.backgroundColor = .clear
    }
    
    func prepareLogoutButton() {
        logoutButton.setTitle(kLogoutButtonTitle, for: .normal)
        logoutButton.setTitleColor(UIColor.black, for: .normal)
        logoutButton.layer.cornerRadius = 0.5 * logoutButton.frame.size.width
        logoutButton.clipsToBounds = true
        logoutButton.backgroundColor = UIColor.lightText
        view.bringSubviewToFront(logoutButton)
        
        logoutButton.addTarget(self, action: #selector(onTapLogoutButton), for: .touchUpInside)
    }
    
    @objc func onTapLogoutButton() {
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                self.toSignInScreen()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func toSignInScreen() {
        let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        UIView.transition(with: window!, duration: 1, options: .transitionCurlDown, animations: {
            window?.rootViewController = vc
            window?.makeKeyAndVisible()
        })
    }
    
    func fetchCountries() {
        NetworkManager.shared.requestApi(stringURL: "https://restcountries-v1.p.rapidapi.com/all", method: .GET) { (result) in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                if let contriesArray = NetworkHelpers.shared.parseCountries(data) {
                    self.countries = contriesArray
                    DispatchQueue.main.async {
                        self.countriesTableView.reloadData()
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}

extension CountriesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredCountries.count : countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as! CountryCell
        
        if isFiltering {
            let country = filteredCountries[indexPath.row]
            cell.countryNameLabel.text = country.name
            cell.countryRegionLabel.text = country.region + " >"
        } else {
            let country = countries[indexPath.row]
            cell.countryNameLabel.text = country.name
            cell.countryRegionLabel.text = country.region + " >"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 8
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = storyboard?.instantiateViewController(identifier: "InfoViewController") as! InfoViewController
        
        if isFiltering {
            vc.country = filteredCountries[indexPath.row]
        } else {
            vc.country = countries[indexPath.row]
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension CountriesViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        guard isFiltering else {
            countriesTableView.reloadData()
            return
        }
        filterContentForSearchText(text)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        NetworkManager.shared.requestApi(stringURL: "https://restcountries-v1.p.rapidapi.com/name/\(searchText)", method: .GET) { (result) in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                if let contriesArray = NetworkHelpers.shared.parseCountries(data) {
                    self.filteredCountries = contriesArray
                    DispatchQueue.main.async {
                        self.countriesTableView.reloadData()
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func onPhotoAction() {
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        // create an action
        let firstAction: UIAlertAction = UIAlertAction(title: "Take Picture", style: .default) { action -> Void in
            AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
                if response {
                    //access granted
                    self.onOpenMedia(source: .camera)
                } else {

                }
            }
            print("First Action pressed")
        }
        
        let secondAction: UIAlertAction = UIAlertAction(title: "Choose from gallery", style: .default) { action -> Void in
            AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
                if response {
                    //access granted
                    self.onOpenMedia(source: .photoLibrary)
                } else {

                }
            }
            print("Second Action pressed")
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }
        // add actions
        actionSheetController.addAction(firstAction)
        actionSheetController.addAction(secondAction)
        actionSheetController.addAction(cancelAction)
        
        // present an actionSheet...
        present(actionSheetController, animated: true, completion: nil)
    }
    
    func onOpenMedia(source: UIImagePickerController.SourceType) {
        DispatchQueue.main.async {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.allowsEditing = true
            pickerController.mediaTypes = ["public.image", "public.movie"]
            pickerController.sourceType = source
            
            self.present(pickerController, animated: true, completion: nil)
        }
    }
    
    func onUploadImage(image: UIImage) {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        StorageManager.shared.uploadImagetoText(photo: image) { (result) in
            switch result {
                
            case .success(let url):
                NetworkManager.shared.getImagetoText(url:url) { (result) in
                    switch result {
                    case .success(let text):
                        NetworkManager.shared.getTranslatedText(text: text) { (result) in
                            switch result {
                                
                            case .success(let data):
                                guard let data = data else { return }
                                guard let text = NetworkHelpers.shared.parseTranslatedText(data) else { return }
                                
                                DispatchQueue.main.async {
                                    self.toNextScreen(text: text)
                                    self.activityIndicator.stopAnimating()
                                    self.activityIndicator.isHidden = true
                                }
                                
                            case .failure(let error):
                                self.showAlert(title: kAlertTitleWrong, message: error.localizedDescription)
                            }
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                    }
            case .failure(_):
                print("error")
            }
        }
    }
    
    func toNextScreen(text: String) {
        DispatchQueue.main.async {
            let vc = self.storyboard?.instantiateViewController(identifier: "TranslateViewController") as! TranslateViewController
            vc.someText = text
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension CountriesViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {return}
        
        onUploadImage(image: selectedImage)
        dismiss(animated: true, completion: nil)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension CountriesViewController: UINavigationControllerDelegate {
    
}
