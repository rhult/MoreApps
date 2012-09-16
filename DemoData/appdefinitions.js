appDefinitions = {
    "company": "Tinybird Interactive",
    "apps": [
        { "id": "shoppy", // Identifier, used to filter out "self" from the app list.
          "name": "Shoppy", // Either a dict with language/name pairs, or just the name if not localized.
          "category": "Lifestyle",
          "summary": { // Same as name, either a dict or just the summary.
			      "en": "Grocery shopping made easy",
			      "sv": "Inköpslista med fokus på enkelhet"
		      },
          "link": "http://itunes.apple.com/app/id421361944?mt=8",
          "icon": "shoppy-114.png",
          "type": "paid",
          "showOnLocales": [], // List of locales, e.g. [ "sv_SE", "nn" ]. Empty list means show on all locales.
          "showOnDevices": [] // List of device types, e.g. [ "iphone", "ipad" ]. Empty list means show on all devices.
        },

        { "id": "intensity",
          "name": "Intensity",
          "category": "Health & Fitness",
          "summary": "Work out like you mean it!",
          "link": "http://itunes.apple.com/app/id497317304?mt=8",
          "icon": "intensity-114.png",
          "type": "paid",
          "showOnLocales": [],
          "showOnDevices": []
        },

        { "id": "nutrientguide",
          "name": {
			      "en": "Nutrient Guide",
			      "sv": "Näringsguide"
		      },
          "category": "Health & Fitness",
          "summary": {
			      "en": "Eat healthy, keep track, take control!",
			      "sv": "Ät hälsosamt, håll koll, ta kontroll!"
		      },
          "link": "http://itunes.apple.com/app/id375930430?mt=8",
          "icon": "nutrientguide-114.png",
          "type": "paid",
          "showOnLocales": [],
          "showOnDevices": []
        },
        { "id": "animalescape",
          "name": {
            "en": "The Animals Have Escaped!",
            "sv": "Djuren har rymt!"
          },
          "category": "Entertainment",
          "summary": {
            "en": "Help Tom find the missing animals and bring them back home",
            "sv": "Hjälp Tom att hitta de bortsprungna djuren och hjälpa dem hem"
          },
          "link": "http://itunes.apple.com/app/id481609947?mt=8&uo=4",
          "icon": "animalescape-114.png",
          "type": "paid",
          "showOnLocales": [],
          "showOnDevices": [ "ipad" ]
        }
    ]
}

affiliateAppDefinitions = {
    "apps": [
       { "id": "addidoku",
         "name": {
           "en": "Addidoku",
         },
         "category": "Games",
         "summary": {
           "en": "Addictive Casual Puzzler",
           "sv": "Beroendeframkallande pusselspel"
         },
         "link": "http://itunes.apple.com/app/id510574334?mt=8",
         "icon": "addidoku-114.png",
         "type": "free",
         "showOnLocales": [],
         "showOnDevices": []
       }
    ]
}
