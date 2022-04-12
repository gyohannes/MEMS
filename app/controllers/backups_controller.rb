class BackupsController < InheritedResources::Base
  load_and_authorize_resource
  add_breadcrumb "Home", :root_path
  add_breadcrumb "Backups", :backups_path

  def index
    @backups = Backup.order('backup_date DESC')
    @backup = Backup.new(backup_date: Date.today)
  end

  def create
    system('rake db:dump')
    @backup = Backup.new(backup_params)
      if @backup.save
        @backup.attachment.attach(io: File.open("/tmp/memis.dump"), filename: "memis.dump")
        redirect_to backups_path, notice: 'Backup created Successfully'
      end
  end

  private

    def backup_params
      params.require(:backup).permit(:backup_date)
    end

end
