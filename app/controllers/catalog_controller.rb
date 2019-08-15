# frozen_string_literal: true
class CatalogController < ApplicationController

  include Blacklight::Catalog
  include Blacklight::Marc::Catalog


  configure_blacklight do |config|
    ## Class for sending and receiving requests from a search index
    # config.repository_class = Blacklight::Solr::Repository
    #
    ## Class for converting Blacklight's url parameters to into request parameters for the search index
    # config.search_builder_class = ::SearchBuilder
    #
    ## Model that maps search index responses to the blacklight response model
    # config.response_model = Blacklight::Solr::Response
    #
    ## Should the raw solr document endpoint (e.g. /catalog/:id/raw) be enabled
    # config.raw_endpoint.enabled = false

    ## Default parameters to send to solr for all search-like requests. See also SearchBuilder#processed_parameters
    config.default_solr_params = {
      rows: 10
    }

    # solr path which will be added to solr base url before the other solr params.
    #config.solr_path = 'select'
    #config.document_solr_path = 'get'

    # items to show per page, each number in the array represent another option to choose from.
    #config.per_page = [10,20,50,100]

    # solr field configuration for search results/index views
    config.index.title_field = 'title_tsiv'
    config.index.partials = [:index_header, :index]
    config.index.display_type_field = 'format'
    config.index.group = false
    #config.index.thumbnail_field = 'thumbnail_path_ss'

    config.add_results_document_tool(:bookmark, partial: 'bookmark_control', if: :render_bookmarks_control?)

    config.add_results_collection_tool(:sort_widget)
    config.add_results_collection_tool(:per_page_widget)
    config.add_results_collection_tool(:view_type_group)

    config.add_show_tools_partial(:bookmark, partial: 'bookmark_control', if: :render_bookmarks_control?)
    config.add_show_tools_partial(:email, callback: :email_action, validator: :validate_email_params)
    config.add_show_tools_partial(:sms, if: :render_sms_action?, callback: :sms_action, validator: :validate_sms_params)
    config.add_show_tools_partial(:citation)

    config.add_nav_action(:bookmark, partial: 'blacklight/nav/bookmark', if: :render_bookmarks_control?)
    config.add_nav_action(:search_history, partial: 'blacklight/nav/search_history')

    # solr field configuration for document/show views
    #config.show.title_field = 'title_tsim'
    #config.show.display_type_field = 'format'
    #config.show.thumbnail_field = 'thumbnail_path_ss'

    # solr fields that will be treated as facets by the blacklight application
    #   The ordering of the field names is the order of the display
    #
    # Setting a limit will trigger Blacklight's 'more' facet values link.
    # * If left unset, then all facet values returned by solr will be displayed.
    # * If set to an integer, then "f.somefield.facet.limit" will be added to
    # solr request, with actual solr request being +1 your configured limit --
    # you configure the number of items you actually want _displayed_ in a page.
    # * If set to 'true', then no additional parameters will be sent to solr,
    # but any 'sniffed' request limit parameters will be used for paging, with
    # paging at requested limit -1. Can sniff from facet.limit or
    # f.specific_field.facet.limit solr request params. This 'true' config
    # can be used if you set limits in :default_solr_params, or as defaults
    # on the solr side in the request handler itself. Request handler defaults
    # sniffing requires solr requests to be made with "echoParams=all", for
    # app code to actually have it echo'd back to see it.
    #
    # :show may be set to false if you don't want the facet to be drawn in the
    # facet bar
    #
    # set :index_range to true if you want the facet pagination view to have facet prefix-based navigation
    #  (useful when user clicks "more" on a large facet and wants to navigate alphabetically across a large set of results)
    # :index_range can be an array or range of prefixes that will be used to create the navigation (note: It is case sensitive when searching values)

    puts "!!!!!!!!! In CatalogController!"

     # Common Metadata Facets
    config.add_facet_field "coll_id_ssi", label: 'Collection ID', limit: 20, index_range: 'A'..'Z'
    config.add_facet_field "dc:creator_tsiv", label: 'DC Creator', limit: 20, index_range: 'A'..'Z'
    config.add_facet_field "dc:subject_tsiv", label: 'DC Subject', limit: 20, index_range: 'A'..'Z'
    config.add_facet_field "dc:date_tsiv", label: 'DC Year', limit: 20, index_range: 'A'..'Z'
    config.add_facet_field "dc:type_tsiv", label: 'DC Topic', limit: 20, index_range: 'A'..'Z'
    config.add_facet_field "dc:genre_tsiv", label: 'DC Genre', limit: 20, index_range: 'A'..'Z'

    # Bentley Historical Library Metadata Facets
    config.add_facet_field "bhl:genre_tsiv", label: 'Bentley: Photographer / Artist'
    config.add_facet_field "bhl:bhl_su_tsiv", label: 'Bentley: Subject', limit: 20, index_range: 'A'..'Z'
    config.add_facet_field "bhl:bhl_g_tsiv", label: 'Bentley: Genre', limit: 20, index_range: 'A'..'Z'
    config.add_facet_field "bhl:bhl_it_tsiv", label: 'Bentley: Title', limit: 20, index_range: 'A'..'Z'

    # Cranial Image Collection Metadata Facets
    config.add_facet_field 'crania1ic:crania1ic_collection_tsiv', label: "Cranial: Collection", limit: 20, index_range: 'A'..'Z'
    config.add_facet_field 'crania1ic:crania1ic_includes_tsiv',  label: "Cranial: Includes", limit: 20, index_range: 'A'..'Z'
    config.add_facet_field 'crania1ic:crania1ic_pathology_symptom_tsiv', label: "Cranial: Symptoms", limit: 20, index_range: 'A'..'Z'
    config.add_facet_field 'crania1ic:crania1ic_sex_ssi', label: "Cranial: Patient Sex"

    # Art Image Collection Metadata Facets
    config.add_facet_field 'hart:hart_cr_tsiv', label: "Art: Artist", limit: 20, index_range: 'A'..'Z'
    config.add_facet_field 'hart:hart_da_tsiv', label: "Art: Created Year", limit: 20, index_range: 'A'..'Z'
    config.add_facet_field 'hart:hart_lo_tsiv', label: "Art: Location", limit: 20, index_range: 'A'..'Z'

    # Kelsey Collection Metadata Facets
    config.add_facet_field 'kelsey:kelsey_colls_tsiv', label: "Kelsey: Collections", limit: 20, index_range: 'A'..'Z'
    config.add_facet_field 'kelsey:kelsey_mat_tsiv', label: "Kelsey: Materials", limit: 20, index_range: 'A'..'Z'
    config.add_facet_field 'kelsey:kelsey_objtype_tsiv', label: "Kelsey: Object Type", limit: 20, index_range: 'A'..'Z'
    config.add_facet_field 'kelsey:kelsey_sit_tsiv', label: "Kelsey: Site", limit: 20, index_range: 'A'..'Z'
    config.add_facet_field 'kelsey:kelsey_verbpro_tsiv', label: "Kelsey: ?Region?'kelsey_verbpro_tsiv'", limit: 20, index_range: 'A'..'Z'


    # config.add_facet_field 'example_query_facet_field', label: 'Publish Date', :query => {
    #    :years_5 => { label: 'within 5 Years', fq: "pub_date_tsiv:[#{Time.zone.now.year - 5 } TO *]" },
    #    :years_10 => { label: 'within 10 Years', fq: "pub_date_tsiv:[#{Time.zone.now.year - 10 } TO *]" },
    #    :years_25 => { label: 'within 25 Years', fq: "pub_date_tsiv:[#{Time.zone.now.year - 25 } TO *]" }
    # }


    # Have BL send all facet field names to Solr, which has been the default
    # previously. Simply remove these lines if you'd rather use Solr request
    # handler defaults, or have no facets.
    config.add_facet_fields_to_solr_request!

    # solr fields to be displayed in the index (search results) view
    #   The ordering of the field names is the order of the display
    config.add_index_field 'coll_id_ssi', label: 'Collection ID'
    config.add_index_field 'dc:title_tsiv', label: 'Title'
    config.add_index_field 'dc:date_tsiv', label: 'Year'
    config.add_index_field 'dc:creator_tsiv', label: 'Creator'
    config.add_index_field 'dc:type_tsiv', label: 'DC Type'

    # solr fields to be displayed in the show (single result) view
    #   The ordering of the field names is the order of the display
    config.add_show_field 'coll_id_ssi', label: 'Collection ID'
    config.add_show_field 'dc:title_tsiv', label: 'Title'
    config.add_show_field 'dc:creator_tsiv', label: 'Creator'
    config.add_show_field 'dc:date_tsiv', label: 'Year'
    config.add_show_field 'dc:subject_tsiv', label: 'Subject'
    config.add_show_field 'dc:description_tsiv', label: 'Description'
    config.add_show_field 'dc:type_tsiv', label: 'DC Type'
    config.add_show_field 'dc:format_ssi', label: 'DC Format'
    config.add_show_field 'dc:source_tsiv', label: 'Source'
    config.add_show_field 'dc:rights_tsiv', label: 'Rights'
    config.add_show_field 'dc:coverage_tsiv', label: 'Coverage'
    config.add_show_field 'dc:genre_tsiv', label: 'Genre'
    config.add_show_field 'dc:member_of_tsiv', label: 'In Collections'

    config.add_show_field 'bhl:bhl_cr_tsiv', label: 'Bentley: Photographer / Artist'
    config.add_show_field 'bhl:bhl_su_tsiv', label: 'Bentley: Subjects'
    config.add_show_field 'bhl:bhl_g_tsiv', label: 'Bentley: Genres'
    config.add_show_field 'bhl:bhl_it_tsiv', label: 'Bentley: Titles'

    config.add_show_field 'crania1ic:crania1ic_collection_tsiv', label: "Cranial: Collections"
    config.add_show_field 'crania1ic:crania1ic_includes_tsiv',  label: "Cranial: Includes"
    config.add_show_field 'crania1ic:crania1ic_pathology_symptom_tsiv', label: "Cranial: Symptoms"
    config.add_show_field 'crania1ic:crania1ic_sex_tsiv', label: "Cranial: Patient Sex"

    config.add_show_field 'hart:hart_cr_tsiv', label: "Art: Artist"
    config.add_show_field 'hart:hart_da_tsiv', label: "Art: Created Year"
    config.add_show_field 'hart:hart_lo_tsiv', label: "Art: Location"
    config.add_show_field 'hart:hart_su_tsiv', label: "Art: Subject"
    config.add_show_field 'hart:hart_vt_tsiv', label: "Art: Location"

    config.add_show_field 'kelsey:kelsey_colls_tsiv', label: "Kelsey: Collections"
    config.add_show_field 'kelsey:kelsey_mat_tsiv', label: "Kelsey: Materials"
    config.add_show_field 'kelsey:kelsey_objtype_tsiv', label: "Kelsey: Object Type"
    config.add_show_field 'kelsey:kelsey_sit_tsiv', label: "Kelsey: Site"
    config.add_show_field 'kelsey:kelsey_verbpro_tsiv', label: "Kelsey: ?Region?'kelsey:kelsey_verbpro_tsiv'"

    # "fielded" search configuration. Used by pulldown among other places.
    # For supported keys in hash, see rdoc for Blacklight::SearchFields
    #
    # Search fields will inherit the :qt solr request handler from
    # config[:default_solr_parameters], OR can specify a different one
    # with a :qt key/value. Below examples inherit, except for subject
    # that specifies the same :qt as default for our own internal
    # testing purposes.
    #
    # The :key is what will be used to identify this BL search field internally,
    # as well as in URLs -- so changing it after deployment may break bookmarked
    # urls.  A display label will be automatically calculated from the :key,
    # or can be specified manually to be different.

    # This one uses all the defaults set by the solr request handler. Which
    # solr request handler? The one set in config[:default_solr_parameters][:qt],
    # since we aren't specifying it otherwise.

    config.add_search_field 'all_fields', label: 'All Fields'


    # Now we see how to over-ride Solr request handler defaults, in this
    # case for a BL "search field", which is really a dismax aggregate
    # of Solr search fields.

    config.add_search_field('title') do |field|
      # solr_parameters hash are sent to Solr as ordinary url query params.
      field.solr_parameters = {
        'spellcheck.dictionary': 'title',
        qf: '${title_qf}',
        pf: '${title_pf}'
      }
    end

    config.add_search_field('creator') do |field|
      field.solr_parameters = {
        'spellcheck.dictionary': 'creator',
        qf: '${author_qf}',
        pf: '${author_pf}'
      }
    end

    # Specifying a :qt only to show it's possible, and so our internal automated
    # tests can test it. In this case it's the same as
    # config[:default_solr_parameters][:qt], so isn't actually neccesary.
    config.add_search_field('subject') do |field|
      field.qt = 'search'
      field.solr_parameters = {
        'spellcheck.dictionary': 'subject',
        qf: '${subject_qf}',
        pf: '${subject_pf}'
      }
    end

    # "sort results by" select (pulldown)
    # label in pulldown is followed by the name of the SOLR field to sort by and
    # whether the sort is ascending or descending (it must be asc or desc
    # except in the relevancy case).
    config.add_sort_field 'score desc, date_tsiv desc, identifier_tsiv asc', label: 'relevance'
    config.add_sort_field 'date_tsiv desc, identifier_tsiv asc', label: 'year'
    config.add_sort_field 'creator_tsiv asc, title_tsiv asc', label: 'creator'
    config.add_sort_field 'title_tsiv asc, date_tsiv desc', label: 'title'

    # If there are more than this many search results, no spelling ("did you
    # mean") suggestion is offered.
    config.spell_max = 5

    # Configuration for autocomplete suggestor
    config.autocomplete_enabled = true
    config.autocomplete_path = 'suggest'
    # if the name of the solr.SuggestComponent provided in your solrcongig.xml is not the
    # default 'mySuggester', uncomment and provide it below
    # config.autocomplete_suggester = 'mySuggester'
  end
end
