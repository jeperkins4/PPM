namespace :pppams do
  namespace :notifications do

    DaysOld = 90

    desc "Remove 'Sent' Notifications that are over #{DaysOld} days old"
    task :purge_sent => :environment do
      Notification.purge_notifications('Sent', DaysOld)
    end

    desc "Remove 'Error' Notifications that are over #{DaysOld} days old"
    task :purge_error => :environment do
      Notification.purge_notifications('Error', DaysOld)
    end

    desc "Remove 'Sent' and 'Error' Notifications that are over #{DaysOld} days old"
    task :purge => :environment do
      Notification.purge_notifications('Error', DaysOld)
      Notification.purge_notifications('Sent', DaysOld)
    end

    desc "Generate Pending Review Notifications"
    task :generate => :environment do
      puts "Generating Pending Review Notifications for #{Time.now.strftime("%B %d, %Y")} ..."
      count = NotificationReport.generate_pending_review_notifications
      puts "#{count} Pending Review #{count == 1 ? 'Notifications' : 'Notifications'} generated."
    end

    desc "Send Pending Review Notifications emails"
    task :deliver => :environment do
      pending = Notification.pending_notifications
      puts "Sending #{pending.size} #{pending.size == 1 ? 'Notification' : 'Notifications'} ..."
      pending.each do |notification|
        puts "  Delivering Notification #{notification.id} to #{notification.to_email} ..."
        notification.deliver_notification
      end
    end

  end

end
