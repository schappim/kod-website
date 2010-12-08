module Extract
  module PageExt
    def self.included(base)
      base.class_eval {
        def is_extract?
          self.is_a?(ExtractPage) || self.is_a?(ExtractArchivePage)
        end
      }
    end
  end
end