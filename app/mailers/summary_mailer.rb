class SummaryMailer < ActionMailer::Base


  def send_summary(txtout, resmon, repos, totals)

    @repos = repos
    @txtout = txtout
    @resmon = resmon
    @totals = totals

    mail :to =>  'montch@gmail.com', :subject => "Summary Mailer" do |format|
      format.html
    end

  end

end