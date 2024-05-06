# frozen_string_literal: true

require_relative "event_scheduler/version"
require "active_support/all" # For date and time calculations

module EventScheduler
  class Event
    attr_accessor :name, :description, :start_time, :end_time, :recurrence_pattern

    def initialize(name, description, start_time, end_time, recurrence_pattern)
      @name = name
      @description = description
      @start_time = start_time
      @end_time = end_time
      @recurrence_pattern = recurrence_pattern
    end

    def schedule
      case recurrence_pattern
      when :daily
        schedule_daily
      when :weekly
        schedule_weekly
      when :monthly
        schedule_monthly
      else
        raise ArgumentError, "Invalid recurrence pattern"
      end
    end

    private

    def schedule_daily
      current_time = @start_time
      while current_time < @end_time
        execute_event(current_time)
        current_time += 1.day
      end
    end

    def schedule_weekly
      current_time = @start_time
      while current_time < @end_time
        execute_event(current_time)
        current_time += 1.week
      end
    end

    def schedule_monthly
      current_time = @start_time
      while current_time < @end_time
        execute_event(current_time)
        current_time = current_time.next_month.at_beginning_of_month
      end
    end

    def execute_event(time)
      # Logic for executing the event
      puts "Executing event '#{name}' at #{time}"
    end
  end
end