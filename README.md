# Photorama
Application named Photorama that reads in a list of interesting photos from Flickr. 

Bronze Challenge: Printing the Response Information
The completion handler for dataTask(with:completionHan‐ dler:) provides an instance of URLResponse. When making HTTP requests, this response is of type HTTPURLResponse (a sub- class of URLResponse).
Print the statusCode and allHeaderFields to the console. These properties are very useful when debugging web service calls.

Silver Challenge: Fetch Recent Photos from Flickr
In this chapter, you fetched the interesting photos from Flickr using the flickr.interestingness.getList endpoint. Add a new case to your EndPoint enumeration for recent photos. The end- point for this is flickr.photos.getRecent. Extend the applica- tion so you are able to switch between interesting photos and recent photos. (Hint: The JSON format for both endpoints is the same, so your existing parsing code will still work.) Note that the recent pho- tos collection is not curated by Flickr, unlike the interesting photos, so you might occasionally come across questionable content.
