# Flowery 🌿
The application consists of two screens: 
- a list of all products 
- product details view after clicking on the chosen product with a collection view for all pictures.

<p align="center">
	<img src="https://github.com/anyashka/Flowery/assets/18245585/9b0d87cf-b91f-403f-be74-f2406400136b" width="250">
<img src="https://github.com/anyashka/Flowery/assets/18245585/a081fce0-9509-4160-815e-c68947ceebf4" width="250">
</p>

## Tools & Frameworks

* Tools:
	* Xcode 14.3.1
	* minimum supported iOS version - iOS 14

## Instalation

1. Open `Flowery.xcodeproj` file.
2. Paste your API key generated on the Plant API [website](https://perenual.com/docs/api) in a file `AppConstants.swift`
3. Run the project.


## Technical features

- Image Caching - using NSCache, so that
images wouldn’t be downloaded each time but cached and reused if possible.
- Image Downloading Logic - each cell downloads an image separately and cancels a
task if it’s not needed. In the details view the logic is similar - the images are being
downloaded one by one instead of all at once.
- Pull to refresh - on the main screen there is a possibility to refresh the content by
pulling a table view.
- Logging functionality
- Universal API logic & flow ones

Disclaimer: lots of things inside the code and features could be improved! Some are mentioned in the comments in code for the sample application purposes. Others could be: pagination, more data, etc.
