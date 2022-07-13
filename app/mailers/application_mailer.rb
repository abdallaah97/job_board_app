class ApplicationMailer < ActionMailer::Base
  default from: "job.board.notifications@gmail.com"
  layout "mailer"
end
