# Reddit old design without logging in
## The not so great solution
You can use the "old" prefix by replacing "www" with "old" like this: https://old.reddit.com/.
This has to be done manually or using some kind of extension or user script.
Instead of trusting an unknown source you can use a simple bookmarklet:

	javascript:location.assign("https://old.reddit.com" + window.location.pathname)

This bookmarklet will redirect you to the old design when you click on it.
Just drag and drop [this link](javascript:location.assign("https://old.reddit.com" + window.location.pathname)) to your bookmarks and it's ready to use.

## The best solution
The best because under the hood it does the same thing as opting out of the redesign with an account through the settings. After it's done it doesn't require any manual intervention.

These steps are specific to Firefox, but it should be similar in other browsers:

1. Go to [reddit.com](https://reddit.com) (it has to be the main page so it works on the entire site).
2. Open the Storage Inspector (Shift + F9) or open the Developer Tools (Ctrl + Shift + I) and click on the Storage tab.
3. Click on the `https://www.reddit.com` section under Cookies.
4. Add a new item by clicking on the + button or by right click -> Add Item.
5. Change the name of the newly created item to "redesign\_optout" and the value to "true".
6. I also recommend setting the "Expires / Max-Age" value to something ridiculous like the year 2100 so the cookie doesn't expire.
