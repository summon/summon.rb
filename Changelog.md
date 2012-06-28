### master
* 2 minor enhancements
  * updated document.from_library? - now uses source_type
  * added document.is_a_i?
* 1 major enhancement
  * attributes defined as boolean will always return boolean values

### 2.0.5
* 1 minor enhancement
  * made document database_title field multi-value
* 1 major enhancement
  * added source field to document

### 2.0.1
* 1 major enhancement
  * added availability_path field

### 2.0.0
* 1 major enhancement
  * added link field to document schema (this now supercedes the url and
    uri fields)

### 1.2.7
* 2 major enhancements
  * added fulltext_hit field to document schema
  * added peer_documents field to document schema

### 1.2.6
* 1 major enhancement
  * added content_types method (multi-value content types)

### 1.2.5
* 1 major enhancement
  * added ERIC field to document schema

### 1.2.4
* 1 major enhancement
  * added print field to document schema

### 1.2.3
* 1 major enhancement
  * authors are now ordered

### 1.2.2 2011-05-22

* 1 minor enhancement:
  * fixed Search.to_s

### 1.2.1 2011-05-22

* 1 major enhancement:
  * Ruby 1.9.2 compatibility fixes

### 1.2.0 2011-04-09

* removed translations
* modernize the gemming process
* support for spotlighting
* Copyright field in document is now multi-value

### 1.1.17 2011-01-28
* 1 minor enhancement
  * copyright field is multi-value (document schema)

### 1.1.16 2011-01-27
* 8 minor enhancements
  * document schema changes
    * renamed dissertation_advisor => dissertation_advisors
    * renamed dissertation_category => dissertation_categories
    * renamed dissertation_degree => dissertation_degrees
    * renamed dissertation_degree_date => dissertation_degrees_dates
    * renamed dissertation_school = dissertation_schools
    * removed dissertation_degree_date_decade
    * removed dissertation_degree_date_century
    * removed dissertation_degree_date_year

### 1.1.15 2011-01-26
* 1 major enhancement
  * added spotlight_children to document schema
* 6 minor enhancements
  * added meeting_name to document schema
  * added deweys to document schema
  * added eisbns to document schema
  * added eissns to document schema
  * added copyright to document schema

### 1.1.14 2010-10-20
* 1 minor enhancement
  * German translation updates

### 1.1.13 2010-10-20
* 1 minor enhancement
  * fix service cloning

### 1.1.12 2010-10-19
* 1 minor enhancement
  * added lib_guide_tabs to document schema

### 1.1.11 2010-09-03
* 1 minor enhancement
  * added dbid field accessor to the document schema

### 1.1.10 2010-05-06
* 4 minor enhancements
  * updated "en" and "xx" locales
  * Added additional translation stubs
  * Added full on translations
  # Added Edition to document schema

### 1.1.9 2010-05-03
* 2 minor enhancement
  * fix japanese translation for Publication Date
  * Added publication_place to document schema

### 1.1.8 2010-03-08
* 1 minor enhancements
  * added from_library? to see if a document is from the library catalog

### 1.1.7 2010-02-18
* 1 minor enhancement
  * allow locale to be specified as either a string or a symbol

### 1.1.6 2010-01-14
* 1 minor enhancement
  * tweak database recommendation lists to make it support multiple recommendations

### 1.1.5 2010-01-13
* 1 major enhancement
  * add support for database recomendation lists

### 1.1.4 2010-01-12
* 4 minor enhancements:
  * add ISICitedReferencesCount for documents on which they're available
  * add ISICitedReferencesURI for document on which available
  * add command line option for setting s.role API parameter
  * map Document::URI field

### 1.1.3 2010-01-11
* 2 major enhancements:
  * support for passing locale to summon gem
  * add japanese language translations

### 1.1.1 2009-12-11
* 2 minor enhancements:
  * add support to handle government document classification number (GovDocClassNum)
  * map error.code into error object to allow for finer grained error messages

### 1.1.0 2009-11-10
* 2 major enhancements:
  * add support for Thumbnails in the thumbnail_small, thumbnail_medium, and thumbnail_large fields
  * add availability service for querying physical catalogue records.
* 2 minor enhancements:
  * add support to handle multiple call numbers.
  * add support for corporate author.
  * add range? to see whether a facet is a range or not
* 1 bug fixes:
  * empty parameter was causing a NameError on the return trip
  * added range? predicate to range facets so that they can be identified as ranges

### 1.0.0 2009-09-28

* 1 major enhancement:
  * Initial Release
