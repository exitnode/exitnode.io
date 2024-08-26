# frozen_string_literal: true

require 'net/http'
require 'json'
require 'icalendar'
require 'icalendar/tzinfo'
require 'time'

module Jekyll
  class DiscordEventsGenerator < Generator
    safe true
    priority :low

    DISCORD_API_BASE_URL = 'https://discord.com/api/v10'

    def generate(site)
      if ENV['JEKYLL_ENV'] == 'production'
        # Configuration
        discord_token = ENV['DISCORD_TOKEN']
        guild_id = ENV['DISCORD_GUILD_ID']
        output_file = site.in_source_dir('assets/cal/discord_events.ics')

        # Fetch events from Discord API
        events = fetch_scheduled_events(discord_token, guild_id)

        # Create iCal calendar
        cal = Icalendar::Calendar.new

        freq = {
          0 => "YEARLY",
          1 => "MONTHLY",
          2 => "WEEKLY",
          3 => "DAILY"
        }

        n_day = {
          0 => "MO",
          1 => "TU",
          2 => "WE",
          3 => "TH",
          4 => "FR",
          5 => "SA",
          6 => "SU",
        }

        cal.timezone do |t|
          t.tzid = "UTC"
        end

        events.each do |event|
          cal.event do |e|
            if event['recurrence_rule']['by_n_weekday']
              e.rrule = "FREQ=#{freq[event['recurrence_rule']['frequency']]};BYDAY=#{event['recurrence_rule']['by_n_weekday'][0]['n']}#{n_day[event['recurrence_rule']['by_n_weekday'][0]['day']]}"
            end
            e.dtstart = Icalendar::Values::DateTime.new(Time.parse(event['scheduled_start_time']), 'tzid' => 'UTC')
            e.dtend = Icalendar::Values::DateTime.new(Time.parse(event['scheduled_end_time']), 'tzid' => 'UTC') if event['scheduled_end_time']
            e.summary = event['name']
            e.description = event['description']
            e.location = event['entity_metadata']&.[]('location').presence || "https://discord.gg/p4AJzcqZZm"
          end
        end

        # Write iCal file
        cal_dir = File.dirname(output_file)
        FileUtils.mkdir_p(cal_dir)
        File.write(output_file, cal.to_ical)

        # Add the generated file to Jekyll's static files
        site.static_files << Jekyll::StaticFile.new(site, site.source, File.dirname(output_file).sub(site.source + '/', ''), File.basename(output_file))
      end
    end

    private

    def fetch_scheduled_events(token, guild_id)
      uri = URI("#{DISCORD_API_BASE_URL}/guilds/#{guild_id}/scheduled-events")
      request = Net::HTTP::Get.new(uri)
      request['Authorization'] = "Bot #{token}"

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(request)
      end

      case response
      when Net::HTTPSuccess
        JSON.parse(response.body)
      else
        puts "Error fetching Discord events: #{response.code} #{response.message}"
        []
      end
    end
  end
end