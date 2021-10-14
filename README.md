# Flowery 🌿
The application consists of two screens: 
- a list of all products 
- product details view after clicking on the chosen product with a collection view for all pictures.

<p align="center">
	<img src="https://user-images.githubusercontent.com/18245585/101287436-8f40cf00-37f0-11eb-84e7-76843afacfbf.png" width="250">
<img src="https://user-images.githubusercontent.com/18245585/101287441-936cec80-37f0-11eb-80e4-c3d5abca1370.png" width="250">
</p>

## Tools & Frameworks

* Tools:
	* Xcode 11.5
	* minimum supported iOS version - iOS 12

## Instalation

1. Open `Flowery.xcodeproj` file and build the project.


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

Disclaimer: lots of things inside the code and features could be improved 😜
