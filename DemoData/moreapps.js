function urlParameter(name)
{
  name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
  var regexS = "[\\?&]"+name+"=([^&#]*)";
  var regex = new RegExp(regexS);
  var results = regex.exec(window.location.href);
  if (results == null) {
    return null;
  } else {
    return results[1];
  }
}

function getDevice()
{
  var device = urlParameter('device');
  if (device == null) {
    if ((navigator.userAgent.match(/iPhone/i)) || (navigator.userAgent.match(/iPod/i))) {
      device = 'iphone';
    } else {
      device = 'ipad';
    }
  }
  return device;
}

function getMe()
{
  var me = urlParameter('me');
  if (me == null) {
    me = '';
  }
  return me;
}

function getLocale()
{
  var locale = urlParameter("locale");
  if (locale == null) {
    locale = 'en_US'
  }
  return locale;
}

function getLanguageFromLocale(locale)
{
  return locale.slice(0, 2);
}

function doesLocaleMatch(locales, locale)
{
  if (locales.length == 0) {
    return true;
  }

  language = locale.slice(0, 2);
  region = locale.slice(-2);

  for (var i = 0; i < locales.length; i++) {
    languageToCheck = locales[i].slice(0, 2);
    regionToCheck = locales[i].slice(-2);
    if (language == languageToCheck || region == regionToCheck) {
      return true;
    }
  }
  return false;
}

function doesDeviceMatch(devices, device)
{
  if (devices.length == 0) {
    return true;
  }

  for (var i = 0; i < devices.length; i++) {
    if (device == devices[i]) {
      return true;
    }
  }
  return false;
}

function filteredAppListForDefinitions(definitions)
{
  device = getDevice();
  locale = getLocale();
  me = getMe();
  var filteredList = [];
  for (var i = 0; i < definitions.apps.length; i++) {
    app = definitions.apps[i];
    if (!doesDeviceMatch(app['showOnDevices'], device)) {
      continue;
    }
    if (!doesLocaleMatch(app['showOnLocales'], locale)) {
      continue;
    }
    if (app['id'] == me) {
      continue;
    }
    filteredList.push(app);
  }
  return filteredList;
}

function generateListForApps(apps)
{
  device = getDevice();
  locale = getLocale();
  language = getLanguageFromLocale(locale);
  iconSubclass = "iconSmall"
  if (device != 'iphone') {
	iconSubclass = "iconLarge"
  }
  var visibleIndex = 0;
  for (var i = 0; i < apps.length; i++) {
    app = apps[i];

	var name = app['name'];
	if (typeof(name) != "string") {
		translatedName = name[language];
		if (translatedName == null) {
			translatedName = name['en'];
		}
		name = translatedName;
	}
	var summary = app['summary'];
	if (typeof(summary) != "string") {
		translatedSummary = summary[language];
		if (translatedSummary == null) {
			translatedSummary = summary['en'];
		}
		summary = translatedSummary;
	}

    document.write("<div id='" + app['id'] + "' class='appBox " + device + "'>")
    if (device != 'iphone') {
      if (app['type'] == 'paid') {
        document.write("<div class='storeButton'><a href='" + app['link'] + "'>View in App Store</a></div>");
      } else {
        document.write("<div class='storeButton'><a href='" + app['link'] + "'>Free in App Store</a></div>");
      }
    }
    document.write("<a href='" + app['link'] + "'><div class='icon " + iconSubclass + "' style='background-image:url(" + app['icon'] + ")'></div></a>");
    document.write("<h2><a href='" + app['link'] + "'>" + name + "</a></h2>");
    document.write("<h3>" + app['category'] + "</h3>");
    document.write("<div class='summary'>" + summary + "</div>");
    document.write("</div>");
  }
}

function generateAppList()
{
  var filteredAppList = filteredAppListForDefinitions(appDefinitions);
  document.write("<h1>More Apps by " + appDefinitions['company'] + "</h1>");
  document.write("<div class='appList'>");
  generateListForApps(filteredAppList);
  document.write("</div>");

  if (typeof(affiliateAppDefinitions) != 'undefined') {
    var filteredAffiliateAppList = filteredAppListForDefinitions(affiliateAppDefinitions);
    if (filteredAffiliateAppList.length > 0) {
      document.write("<div class='affiliateBox'>");
      document.write("<h1>Apps by Affiliates</h1>");
      document.write("<div class='appList'>");
      generateListForApps(filteredAffiliateAppList);
      document.write("</div>");
      document.write("</div>");
    }
  }
}
