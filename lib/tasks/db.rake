# lib/tasks/db.rake
namespace :db do
  desc "Dumps the database"
  task :dump => :environment do
    cmd = nil
    with_config do |app, host, db, user, passwrd|
      cmd = "export PGPASSWORD='#{passwrd}' && pg_dump --host #{host} --username #{user} -w --verbose --clean --no-owner --no-acl --format=c #{db} > /tmp/swmoss_db.dump"
    end
    puts cmd
    exec cmd
  end

  desc "Restores the database dump."
  task :restore, [:backup] => :environment do |t, args|
    cmd = nil
    with_config do |app, host, db, user, passwd|
      cmd = "export PGPASSWORD='#{passwd}' && pg_restore --verbose --host #{host} --username #{user} -w -c -C --no-owner --no-acl --dbname #{db} #{args[:backup]}"
    end
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    puts cmd
    exec cmd
  end

  private

  def with_config
    yield Rails.application.class.parent_name.underscore,
        ActiveRecord::Base.connection_config[:host],
        ActiveRecord::Base.connection_config[:database],
        ActiveRecord::Base.connection_config[:username],
        ActiveRecord::Base.connection_config[:password]
  end

end