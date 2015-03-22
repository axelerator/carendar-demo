class HomeController < ApplicationController


  def index
    r = Random.new(125)
    week = DateTime.now.beginning_of_week
    ungrouped_items = 40.times.map do |i|
      day = r.rand(12).to_i
      s_time = r.rand(265).to_i
      e_time = r.rand([268 - s_time - 1, 60].min + 15).to_i + 1 + s_time
      opts = { title: Faker::Lorem.words(2).join(" ") }
      if s_time.even?
        opts[:class] = 'important' # separate classes can be passed to single events
                                   # for individual styling
      end
      {
        starts_at: week + day.days + (5* s_time).minutes,
        ends_at: week + day.days + (5*e_time).minutes,
        options: opts
      }
    end
    @calendar_month = Carendar::Calendar.new(DateTime.now.beginning_of_month, DateTime.now.end_of_month, ungrouped_items)
    @calendar_week = Carendar::Calendar.new(DateTime.now.beginning_of_week, DateTime.now.end_of_week, ungrouped_items)
  end
end
