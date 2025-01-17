//
//  ViewController.swift
//  Weather App
//
//  Created by Augusto Enoque das Neves Gouveia on 23/05/24.
//

import UIKit

class ViewController: UIViewController {
    
    
    private lazy var backgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Background")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var headerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.constrastColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Petrolina"
        label.textAlignment = .center
        label.textColor = UIColor.primaryColor
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 70, weight: .bold)
        label.text = "32ºC"
        label.textAlignment = .left
        label.textColor = UIColor.primaryColor
        return label
    }()
    
    private lazy var weatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(resource: .sunIcon)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var humidityLabel: UILabel = {
        let humidityLabel = UILabel()
        humidityLabel.translatesAutoresizingMaskIntoConstraints = false
        humidityLabel.text = "Umidade"
        humidityLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        humidityLabel.textColor = UIColor.constrastColor
        return humidityLabel
    }()
    
    private lazy var humidityValueLabel: UILabel = {
        let humidityLabel = UILabel()
        humidityLabel.translatesAutoresizingMaskIntoConstraints = false
        humidityLabel.text = "1000mm"
        humidityLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        humidityLabel.textColor = UIColor.constrastColor
        return humidityLabel
    }()
    
    private lazy var humidityStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [humidityLabel, humidityValueLabel])
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var windLabel: UILabel = {
        let humidityLabel = UILabel()
        humidityLabel.translatesAutoresizingMaskIntoConstraints = false
        humidityLabel.text = "Vento"
        humidityLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        humidityLabel.textColor = UIColor.constrastColor
        return humidityLabel
    }()
    
    private lazy var windValueLabel: UILabel = {
        let humidityLabel = UILabel()
        humidityLabel.translatesAutoresizingMaskIntoConstraints = false
        humidityLabel.text = "10km/h"
        humidityLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        humidityLabel.textColor = UIColor.constrastColor
        return humidityLabel
    }()
    
    private lazy var windStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [windLabel, windValueLabel])
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var statsStackView: UIStackView = {
        let statsStackView = UIStackView(arrangedSubviews: [humidityStackView, windStackView])
        statsStackView.axis = .vertical
        statsStackView.spacing = 12
        statsStackView.backgroundColor = UIColor.softGrayColor
        statsStackView.layer.cornerRadius = 10
        statsStackView.translatesAutoresizingMaskIntoConstraints = false
        statsStackView.isLayoutMarginsRelativeArrangement = true
        statsStackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24)
        
        return statsStackView
    }()
    
    private lazy var hourlyForecastLabel: UILabel = {
        let label = UILabel()
        label.text = "previsão por hora".uppercased()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.constrastColor
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var hourlyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 67, height: 84)
        layout.sectionInset = UIEdgeInsets(top: .zero, left: 12, bottom: .zero, right: 12)
        
        let collectionView = UICollectionView(frame: .zero , collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(HourlyForecastCollectionViewCell.self, forCellWithReuseIdentifier: HourlyForecastCollectionViewCell.indentifier)
        return collectionView
    }()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy(){
        view.addSubview(backgroundView)
        view.addSubview(headerView)
        view.addSubview(statsStackView)
        view.addSubview(hourlyForecastLabel)
        view.addSubview(hourlyCollectionView)
        
        headerView.addSubview(cityLabel)
        headerView.addSubview(temperatureLabel)
        headerView.addSubview(weatherIcon)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60 ),
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 35),
            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -35),
            headerView.heightAnchor.constraint(equalToConstant: 169)
        ])
        
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 15),
            cityLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
            cityLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -15),
            cityLabel.heightAnchor.constraint(equalToConstant: 20),
            temperatureLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 21),
            temperatureLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 26),
            weatherIcon.heightAnchor.constraint(equalToConstant: 86),
            weatherIcon.widthAnchor.constraint(equalToConstant: 86),
            weatherIcon.trailingAnchor.constraint(equalTo:  headerView.trailingAnchor, constant: -26),
            weatherIcon.centerYAnchor.constraint(equalTo: temperatureLabel.centerYAnchor),
            weatherIcon.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            statsStackView.widthAnchor.constraint(equalToConstant: 206),
            statsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statsStackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 24)
        ])
        
        NSLayoutConstraint.activate([
            hourlyForecastLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hourlyForecastLabel.topAnchor.constraint(equalTo: statsStackView.bottomAnchor, constant: 29),
            hourlyForecastLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            hourlyForecastLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            hourlyCollectionView.topAnchor.constraint(equalTo: hourlyForecastLabel.bottomAnchor, constant: 22),
            hourlyCollectionView.heightAnchor.constraint(equalToConstant: 84),
            hourlyCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hourlyCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyForecastCollectionViewCell.indentifier, for: indexPath)
        return cell
    }
}
