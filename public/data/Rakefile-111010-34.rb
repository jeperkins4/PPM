SOURCE_DIRECTORY = '/home/aaaa/development'
EXCLUDES         = ['log/*.log']
BACKUP_DIRECTORY = '/mnt/hgfs/tellesb/development'
BACKUPS_TO_STORE = 5
require 'aoeu'
desc 'make file'
task :mkfile do
  Aoeu.mk('/home/aaaa/shared/files/4e6')
end
desc 'Backup development directory files'
task :backup do 
  require 'find'

  if File.exist?(BACKUP_DIRECTORY) && File.exist?(SOURCE_DIRECTORY)
    BackupUtil.synchronize_home_directory
    #BackupUtil.backup_tar_zipped
  else
    puts "The specified backup directory (#{BACKUP_DIRECTORY})does not exist."
  end
end
class BackupUtil

  def self.backup_file(name)
    File.exist?(backup_file_path(name)) ?  File.open(backup_file_path(name)) : false
  end

  def self.backup_file_path(name)
    BACKUP_DIRECTORY+'/'+name
  end

  def self.backup_tar_zipped
    puts "Backing up tar-zipped files"
    excludes = EXCLUDES.map {|e| "--exclude \"#{SOURCE_DIRECTORY}/#{e}\""}.join(' ')
    if `tar cvpzf "#{BACKUP_DIRECTORY}/home_dir_backup_#{Time.now.strftime('%Y-%m-%d-%H-%M-%S')}.tgz" #{excludes} "#{SOURCE_DIRECTORY}"` 
      if FileList["#{BACKUP_DIRECTORY}/*"].size > 5
	files_newest_to_oldest = FileList["#{BACKUP_DIRECTORY}/*"].sort {|a,b| File.open(b).mtime <=> File.open(a).mtime}
        #debugger
        files_newest_to_oldest.shift(5)
        files_newest_to_oldest.each do |old_file|
          File.delete(old_file) if File.file?(old_file)
        end
      end
      puts "Completed backing up tar-zip files."
    else
      puts "Tar zipping failed for some reason."
    end
  end

  def self.synchronize_home_directory
    if `unison "#{SOURCE_DIRECTORY}" "#{BACKUP_DIRECTORY}/latest_full_home_directory" -batch -times -silent -ui text`
      puts "Completed backing up home directory"
    end
  end

end
