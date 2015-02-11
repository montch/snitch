class SummaryMailer < ActionMailer::Base


  def send_summary(txtout, resmon, repos, totals)

    @repos = repos
    @txtout = txtout
    @resmon = resmon
    @totals = totals

    mail :to =>  'jen@ignitewithus.com, mark@ignitewithus.com', :subject => "Snitch Summary Mailer", :from => "snitch@ignitewithus.com" do |format|
      format.html
    end

  end

end