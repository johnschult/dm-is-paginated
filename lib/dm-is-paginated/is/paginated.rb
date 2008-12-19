module DataMapper
  module Is
    module Paginated
      def is_paginated(options = {})
        extend  DataMapper::Is::Paginated::ClassMethods
      end

      module ClassMethods
        def paginated(options = {})

          options[:page] ||= 1
          options[:per_page] ||= 5
          
          page     = options.delete(:page).to_i
          per_page = options.delete(:per_page).to_i

          options.reverse_merge!({
            :order => [:id.desc]
          })
          number_of_records = count(options)
          page_count = (number_of_records.to_f / per_page).ceil

          options.merge!({
            :limit => per_page,
            :offset => (page - 1) * per_page
          })

          [ number_of_records, page_count.to_i , all(options) ]
        end
      end
    end
  end
end
