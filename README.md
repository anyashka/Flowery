# Flowery
The application consists of two screens: one with a list of all products and one with product details view after clicking on the chosen product.

## Tools & Frameworks

* Tools:
	* Xcode 11.5

## Instalation

1. Open `Flowery.xcodeproj` file and build the project.


## Additional information

### What was additionaly added

● Logging functionality​ - I believe it is great addition to all applications

● Universal API logic & flow​ ones: for testing application it could be skipped but I
wanted to show the generic approach that would be nice to use for applications that
would be further developed

● Image Caching - ​I’ve added an image caching functionality using NSCache, so that
images wouldn’t be downloaded each time but cached and reused if possible.

● Image Downloading Logic ​- each cell downloads an image separately and cancels a
task if it’s not needed. In the details view the logic is similar - the images are being
downloaded one by one instead of all at once.

● Pull to refresh - ​on the main screen there is a possibility to refresh the content by
pulling a table view.

### What could be improved

● Tests ​- the code coverage definitely could be higher.

● Documentation ​- I've skipped documentation for some objects. It could be added to more places.

● Analytics ​- for production apps I would suggest using it.

● Environments setups​ (development, staging, production) - for production applications it's a must have.

● Image Size ​- We could get smaller image sizes for the product list view. In that case, fetching would be quicker.

● Showing more details about products - for the test application I've used only full price, didn't show ranking, and a lot of additional information.