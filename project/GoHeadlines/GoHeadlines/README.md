# Go Headlines

## Author Details
Author: Manogna Podishetty 
Redid : 824732058
working: single


## Description

The swift ui app works gather news feeds from "https://newsapi.org/" using REST API from "newsapi.org". 

### Features in the app 

      - The app gathers top headlines from different sources (CNN,CBSE) using REST APIs from newsapi.org
      - The app can work on two modes which can be accessed from gear icon settings
        - top headlines (default when app loads)
        - everything
      - the gear icon gives user to select options like source/country/language/number_of_articles_to_retrive to search news from
        - the setting view will also restrict user option based on selection mode (top-headlines, everything)
        - it also tell users what option are diabled when selection source option
      - You can search for any news within the "newsapi.org" using the search bar text field. (search is dynamic)
      - User can select the article content by clicking the article in main view
      - You save any an article into core data by clicking the "tray.and.arrow.down.fill" after opening the news
      - when you save an article 
        - the article that is saved has a forcebaclground in green in the main view 
        - the nav items list tell you how many articles have been saved
        - User can press the "tray.and.arrow.up.fill" icon to list all the saved article 
            - "tray.and.arrow.up.fill" on green will shows only saved articles
            - "tray.and.arrow.up.fill" on blue will get content from newsapi.org


        
## Know issues

      - if more then 2 sources are selected from the setting -> news sources option, the app fails to load data from newsapi.org.
      - the app very rarely crashes while loading images from website url beacuse of nil.
      - even throw if set the results option in setting to a number like 90, newapi.org restricts data to < 40 articles
      - the country setting only shows 2 char for country code
      - console log error beacuse of failure to load images from url sources (bad urls,invalid website)




