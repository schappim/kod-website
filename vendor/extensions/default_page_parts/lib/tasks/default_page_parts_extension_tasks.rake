namespace :radiant do
  namespace :extensions do
    namespace :default_page_parts do
      
      desc "Runs the migration of the Default Page Parts extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          DefaultPagePartsExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          DefaultPagePartsExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Default Page Parts to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        Dir[DefaultPagePartsExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(DefaultPagePartsExtension.root, '')
          directory = File.dirname(path)
          puts "Copying #{path}..."
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end  
    end
  end
end
