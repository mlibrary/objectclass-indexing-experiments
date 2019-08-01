require "pp"

namespace :data do
  desc "Index data"
  task :index => :environment do
    json_data = File.read("./data/bhl/bhl:bbt1913.json")
    json_doc = JSON.parse(json_data)
    conn = Blacklight.default_index.connection
    solr_doc = {}
    solr_doc["id"] = json_doc["dc:identifier"][0]
    solr_doc = flatten_json(json_doc, solr_doc)
    conn.add solr_doc
    conn.commit
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

