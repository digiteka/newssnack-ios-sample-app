//
//  ViewController.swift
//  NewsSnackSample
//
//  Created by Cédric Derache on 20/09/2023.
//

import UIKit
import VideoFeedSDK

class ViewController: UIViewController {
    @IBOutlet private weak var scrollView: UIScrollView! {
        didSet {
            scrollView.showsVerticalScrollIndicator = false
        }
    }
    // MARK: - Fonts IBOutlets
    @IBOutlet private weak var fontSizeLabel: UILabel! {
        didSet {
            fontSizeLabel.text = "title_font_size".localize
        }
    }
    // MARK: Title Font IBOutlets
    @IBOutlet private weak var titleFontSizeLabel: UILabel! {
        didSet {
            titleFontSizeLabel.text = "choose_title_font_size".localize
        }
    }
    @IBOutlet private weak var titleDefaultSizeLabel: UILabel! {
        didSet {
            titleDefaultSizeLabel.text = "default_font_size".localize
        }
    }
    @IBOutlet private weak var titleFontSystemSwitch: UISwitch! {
        didSet {
            titleFontSystemSwitch.isOn = true
        }
    }
    @IBOutlet private weak var currentValueTitleSliderLabel: UILabel!
    @IBOutlet private weak var fontSizeTitleSlider: UISlider! {
        didSet {
            fontSizeTitleSlider.minimumValue = 10
            fontSizeTitleSlider.maximumValue = 42
            fontSizeTitleSlider.value = 25
            fontSizeTitleSlider.isEnabled = false
        }
    }
    // MARK: Description Font IBOutlets
    @IBOutlet private weak var descriptionFontSizeLabel: UILabel! {
        didSet {
            descriptionFontSizeLabel.text = "choose_description_font_size".localize
        }
    }
    @IBOutlet private weak var descriptionDefaultSizeLabel: UILabel! {
        didSet {
            descriptionDefaultSizeLabel.text = "default_font_size".localize
        }
    }
    @IBOutlet private weak var descriptionFontSystemSwitch: UISwitch! {
        didSet {
            descriptionFontSystemSwitch.isOn = true
        }
    }
    @IBOutlet private weak var currentValueDescriptionSliderLabel: UILabel!
    @IBOutlet private weak var fontSizeDescriptionSlider: UISlider! {
        didSet {
            fontSizeDescriptionSlider.minimumValue = 10
            fontSizeDescriptionSlider.maximumValue = 42
            fontSizeDescriptionSlider.value = 25
            fontSizeDescriptionSlider.isEnabled = false
        }
    }
    // MARK: Zone Font IBOutlets
    @IBOutlet private weak var zoneFontSizeLabel: UILabel! {
        didSet {
            zoneFontSizeLabel.text = "choose_zone_font_size".localize
        }
    }
    @IBOutlet private weak var zoneDefaultSizeLabel: UILabel! {
        didSet {
            zoneDefaultSizeLabel.text = "default_font_size".localize
        }
    }
    @IBOutlet private weak var zoneFontSystemSwitch: UISwitch! {
        didSet {
            zoneFontSystemSwitch.isOn = true
        }
    }
    @IBOutlet private weak var currentValueZoneSliderLabel: UILabel!
    @IBOutlet private weak var fontSizeZoneSlider: UISlider! {
        didSet {
            fontSizeZoneSlider.minimumValue = 10
            fontSizeZoneSlider.maximumValue = 42
            fontSizeZoneSlider.value = 25
            fontSizeZoneSlider.isEnabled = false
        }
    }
    // MARK: - Theme IBOutlets
    @IBOutlet private weak var displayLabel: UILabel! {
        didSet {
            displayLabel.text = "display".localize
        }
    }
    @IBOutlet private weak var themeSelectorControl: UISegmentedControl! {
        didSet {
            themeSelectorControl.setTitle("Clair", forSegmentAt: 0)
            themeSelectorControl.setTitle("Sombre", forSegmentAt: 1)
            themeSelectorControl.setTitle("Auto", forSegmentAt: 2)
        }
    }
    // MARK: - Images IBOutlets
    @IBOutlet private weak var imagesLabel: UILabel! {
        didSet {
            imagesLabel.text = "images".localize
        }
    }
    @IBOutlet private weak var defaultPlayLabel: UILabel! {
        didSet {
            defaultPlayLabel.text = "default_play".localize
        }
    }
    @IBOutlet private weak var playImageSwitch: UISwitch! {
        didSet {
            playImageSwitch.isOn = true
        }
    }
    @IBOutlet private weak var defaultPauseLabel: UILabel! {
        didSet {
            defaultPauseLabel.text = "default_pause".localize
        }
    }
    @IBOutlet private weak var pauseImageSwitch: UISwitch! {
        didSet {
            pauseImageSwitch.isOn = true
        }
    }
    @IBOutlet private weak var defaultEmptyStateLabel: UILabel! {
        didSet {
            defaultEmptyStateLabel.text = "default_empty_state".localize
        }
    }
    @IBOutlet private weak var emptyStateImageSwitch: UISwitch!
    {
        didSet {
            emptyStateImageSwitch.isOn = true
        }
    }
    // MARK: - Open Button IBOutlet
    @IBOutlet private weak var openButton: UIButton! {
        didSet {
            openButton.layer.cornerRadius = 10
            openButton.setTitle("open".localize, for: .normal)
        }
    }
    
    // MARK: - Private vars
    private var titleFont: UIFont?
    private var descriptionFont: UIFont?
    private var zoneFont: UIFont?
    private var forcedUserInterfaceStyle: UIUserInterfaceStyle?
    private var playImage: String?
    private var pauseImage: String?
    private var emptyStateImage: String?
    
    private func getCurrentSelectedTheme() -> UIUserInterfaceStyle? {
        switch themeSelectorControl.selectedSegmentIndex {
        case 0:
            return .light
        case 1:
            return .dark
        default:
            return nil
        }
    }
    
    // MARK: - Lifecyle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTitleFont()
        updateDescriptionFont()
        updateZoneFont()
    }
    
    private func updateTitleFont() {
        currentValueTitleSliderLabel.text = String(Int(self.fontSizeTitleSlider.value))
        titleFont = titleFontSystemSwitch.isOn ? nil : UIFont.systemFont(ofSize: CGFloat(fontSizeTitleSlider.value))
    }
    
    private func updateDescriptionFont() {
        currentValueDescriptionSliderLabel.text = String(Int(self.fontSizeDescriptionSlider.value))
        descriptionFont = descriptionFontSystemSwitch.isOn ? nil : UIFont.systemFont(ofSize: CGFloat(fontSizeDescriptionSlider.value))
    }
    
    private func updateZoneFont() {
        currentValueZoneSliderLabel.text = String(Int(self.fontSizeZoneSlider.value))
        zoneFont = zoneFontSystemSwitch.isOn ? nil : UIFont.systemFont(ofSize: CGFloat(fontSizeZoneSlider.value))
    }
    
    @IBAction private func titleFontSystemSwitch(_ sender: UISwitch) {
        fontSizeTitleSlider.isEnabled = !titleFontSystemSwitch.isOn
        updateTitleFont()
    }
    
    @IBAction private func fontSizeTitleSlider(_ sender: UISlider) {
        updateTitleFont()
    }
    
    @IBAction private func descriptionFontSystemSwitch(_ sender: UISwitch) {
        fontSizeDescriptionSlider.isEnabled = !descriptionFontSystemSwitch.isOn
        updateDescriptionFont()
    }
    
    @IBAction private func fontSizeDescriptionSlider(_ sender: UISlider) {
        updateDescriptionFont()
    }
    
    @IBAction private func zoneFontSystemSwitch(_ sender: UISwitch) {
        fontSizeZoneSlider.isEnabled = !zoneFontSystemSwitch.isOn
        updateZoneFont()
    }
    
    @IBAction private func fontSizeZoneSlider(_ sender: UISlider) {
        updateZoneFont()
    }
    
    @IBAction private func themeSelectorControl(_ sender: UISegmentedControl) {
        forcedUserInterfaceStyle = getCurrentSelectedTheme()
    }
    
    @IBAction private func playImageSwitch(_ sender: UISwitch) {
        playImage = playImageSwitch.isOn ? nil : "Play"
    }
    
    @IBAction private func pauseImageSwitch(_ sender: UISwitch) {
        pauseImage = pauseImageSwitch.isOn ? nil : "Pause"
    }
    
    @IBAction private func emptyStateImageSwitch(_ sender: UISwitch) {
        emptyStateImage = emptyStateImageSwitch.isOn ? nil : "EmptyState"
    }
    
    @IBAction private func openButtonTapped(_ sender: UIButton) {
        do {
            let vc = try VideoFeed.shared.videoFeedViewController(
                uiConfig: DTKNSUIConfig(
                    forcedUserInterfaceStyle: forcedUserInterfaceStyle,
                    titleFont: titleFont,
                    descriptionFont: descriptionFont,
                    zoneFont: zoneFont,
                    playImageName: playImage,
                    pauseImageName: pauseImage,
                    emptyStateImageName: emptyStateImage,
                    adsDisabled: false,
                    tagParamsFor: { zoneName, adId in
                        return ["zone": zoneName, "ad": adId]
                    }
                ),
                injector: CustomInjector()
            )
            navigationController?.pushViewController(vc, animated: true)
        } catch {
            print(error)
        }
    }
}
