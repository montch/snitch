class ApprovalResponseWorker
  include Sidekiq::Worker
  include Snitchlib

  def perform( )



    SummaryMailer.send_summary().deliver
  end

end

#Sidekiq::Cron::Job.create(name: 'Hard worker - every 5min', cron: '*/5 * * * *', klass: 'HardWorker')

