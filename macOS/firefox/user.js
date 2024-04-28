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

// Disable Quick Find, since it's conflicting with Vimium
user_pref("accessibility.typeaheadfind", false);
user_pref("accessibility.typeaheadfind.manual", false);
user_pref("accessibility.typeaheadfind.autostart", false);

// Press <Tab> to hide the address bar
user_pref("browser.toolbars.keyboard_navigation", false);
