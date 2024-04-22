// Reduce tab bar's height
user_pref("browser.compactmode.show", true);

// Remove "List all Tabs" button on the right side of the tab bar
user_pref("browser.tabs.tabmanager.enabled", false);

// Open context menu search in background tab
user_pref("browser.search.context.loadInBackground", true);

// Disable Pocket
user_pref("extensions.pocket.enabled", false);

// Disable Google suggestions
user_pref("browser.search.suggest.enabled", false);
user_pref("browser.urlbar.suggest.searches", false);

// Highlight all words when searching
user_pref("findbar.highlightAll", true);

// Allow adding custom search engines
user_pref("browser.urlbar.update2.engineAliasRefresh", true);
