class CollRecord < ApplicationRecord
	after_save :index_record
	# before_destroy :remove_from_index

	attr_accessor :id,  :identifier, :creator, :title, :dc_format, :coverage, :date, :source, :rights, :type, :description, :genre, :member_of, :bhl_cr, :bhl_el, :bhl_g; :bhl_su, :bhl_it, :crania1ic_collection, :crania1ic_includes, :crania1ic_pathology_symptom, :crania1ic_sex, :hart_cr, :hart_da, :hart_lo, :hart_ordno, :hart_vt, :hart_wono, :kelsey_colls, :kelsey_lot,  :kelsey_mat,  :kelsey_objtype,  :kelsey_sit,  :kelsey_verbpro

	def to_solr
		{ # Common Metadata
			'id' => id,
			'identifier_ssi' => identifier, #coll id
			'creator_ssim' => creator,
			'subject_ssim' => subject,
			'title_tsim' => title,
			'format_ssi' => dc_format,
			'coverage_ssim' => coverage,
			'date_ssim' => date,
			'source_ssim' => source,
			'rights_ssim' => rights,
			'type_ssim' => dc_type,
			'description_tesi' => description,
			'genre_ssim' => genre,
			'member_of_tesi' => member_of,
			# Collection Specific Metadata
			'bhl_cr_ssim' => bhl_cr,
			'bhl_el_ssim' => bhl_el,
			'bhl_g_ssim' => bhl_g,
			'bhl_su_ssim' => bhl_su,
			'bhl_it_ssim' => bhl_it,

			'crania1ic_collection_ssim' => crania1ic_collection,
			'crania1ic_includes_ssim' => crania1ic_includes,
			'crania1ic_pathology_symptom_ssim' => crania1ic_pathology_symptom,
			'crania1ic_sex_ssi' => crania1ic_sex,

			'hart_cr_ssim' => hart_cr,
			'hart_da_ssim' => hart_da,
			'hart_lo_ssim' => hart_lo,
			'hart_ordno_int' => hart_ordno,
			'hart_su_ssim' => hart_su,
			'hart_vt_ssim' => hart_vt,
			'hart_wono_int' => hart_wono,

			'kelsey_colls_ssim' => kelsey_colls,
			'kelsey_lot_ssim' => kelsey_lot,
			'kelsey_mat_ssim' => kelsey_mat,
			'kelsey_objtype_ssim' => kelsey_objtype,
			'kelsey_sit_ssim' => kelsey_sit,
			'kelsey_verbpro_ssim' => kelsey_verbpro
		}
	end

  def index_record
  	conn = Blacklight.default_index.connection
  	doc = { # Common Metadata
			'id' => id,
			'identifier_ssi' => identifier, #coll id
			'creator_ssim' => creator,
			'subject_ssim' => subject,
			'title_tsim' => title,
			'format_ssi' => dc_format,
			'coverage_ssim' => coverage,
			'date_ssim' => date,
			'source_ssim' => source,
			'rights_ssim' => rights,
			'type_ssim' => dc_type,
			'description_tesi' => description,
			'genre_ssim' => genre,
			'member_of_tesi' => member_of,
			# Collection Specific Metadata
			'bhl_cr_ssim' => bhl_cr,
			'bhl_el_ssim' => bhl_el,
			'bhl_g_ssim' => bhl_g,
			'bhl_su_ssim' => bhl_su,
			'bhl_it_ssim' => bhl_it,

			'crania1ic_collection_ssim' => crania1ic_collection,
			'crania1ic_includes_ssim' => crania1ic_includes,
			'crania1ic_pathology_symptom_ssim' => crania1ic_pathology_symptom,
			'crania1ic_sex_ssi' => crania1ic_sex,

			'hart_cr_ssim' => hart_cr,
			'hart_da_ssim' => hart_da,
			'hart_lo_ssim' => hart_lo,
			'hart_ordno_int' => hart_ordno,
			'hart_su_ssim' => hart_su,
			'hart_vt_ssim' => hart_vt,
			'hart_wono_int' => hart_wono,

			'kelsey_colls_ssim' => kelsey_colls,
			'kelsey_lot_ssim' => kelsey_lot,
			'kelsey_mat_ssim' => kelsey_mat,
			'kelsey_objtype_ssim' => kelsey_objtype,
			'kelsey_sit_ssim' => kelsey_sit,
			'kelsey_verbpro_ssim' => kelsey_verbpro
		} 

		conn.add doc
	  conn.commit

    # SolrService.add(self.to_solr)
    # SolrService.commit
  end

  # def remove_from_index
  #   SolrService.delete_by_id(self.id)
  #   SolrService.commit
  # end
end
