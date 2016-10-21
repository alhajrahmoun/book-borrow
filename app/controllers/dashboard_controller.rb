class DashboardController < ApplicationController
  def index
  	@users = User.where(approved: true)
  end

  def hello
  	Pusher.trigger('test_channel', 'my_event', {
      message: 'hello world'
    })
  end
end
