require 'pp'

namespace :data do
  desc 'Index data into solr'
  task index: :environment do

    # Set up BL indexing connection
    conn = Blacklight.default_index.connection

    # Set up directories for json files
    json_dirs = Dir.glob("./data/**/*/")
    pp "List of data directories found:"
    pp json_dirs

    # For each json directory, get the files
    json_dirs.each do |data_dir|
        pp "Processing files in directory #{data_dir}"
        # display_flag = 0

        current_json_files = Dir.glob("#{data_dir}/**/*")
        # For each file get the data, create a solr doc, and add to solr
        current_json_files.each do |json_file|
        # pp "processing file #{json_file}"
        print "."
        json_data = File.read(json_file)
        json_doc = JSON.parse(json_data)
        solr_doc = {}
        solr_doc['id'] = json_doc['dc:identifier'][0]
        solr_doc['coll_id_ssi'] = solr_doc['id'].split(':')[0]
        solr_doc = flatten_json(json_doc, solr_doc)
        conn.add solr_doc
        conn.commit
      end
      puts " "
    end
  end
end

def flatten_json(source, target, prefix="")
  source.keys.each do |key|
    if source[key].is_a?(Array)
      value = source[key][0]
    else
      value = source[key]
    end
    if value.is_a?(Hash)
      target = flatten_json(value, target, key)
    else
      if prefix != ''
        new_key = "#{prefix}_#{key}_tsiv"
      else
        new_key = "#{key}_tsiv"
      end
      target[new_key] = value
    end
  end
  return target
end
