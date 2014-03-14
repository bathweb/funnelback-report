require 'net/http'
require 'net/https'
require 'fileutils'

require 'nokogiri'
require 'open-uri'

# require 'sinatra'

class GenerateFunnelbackReport

    FUNNELBACK_REPORT_HTML = "report.html"
    USAGE_CHART_HTML = "usage-summary-chart.html"

    attr_reader :monthly_usage_filename
    attr_reader :usage_chart_filename
    attr_reader :output_location

    def initialize(output_location)

        @monthly_usage_filename = "monthly-usage-table.html"
        @usage_chart_filename = "usage-summary-chart.png"

        if !output_location.end_with? "/"
            output_location = output_location + "/"
        end

        @output_location = output_location
        if !File.exists?(@output_location)
            FileUtils.mkdir(@output_location)
        end

        # Set up HTTP client to get report page and get past HTTP Auth
        @http = Net::HTTP.new(ENV['FUNNELBACK_URL'],8443)
        @http = Net::HTTP.new(ENV['FUNNELBACK_URL'],8443)
        @http.use_ssl = true
        @http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    end

    def fetch_monthly_usage(report_url)

        self.fetch_funnelback_content(report_url, monthly_usage_filename)

        monthly_usage_table = @doc.css('div.summary_report table')[0]
        open(@output_location + monthly_usage_filename, "wb") { |file|
            file.write(monthly_usage_table)
        }

    end

    def fetch_usage_chart(report_url)

        self.fetch_funnelback_content(report_url, USAGE_CHART_HTML)

        chart_url = @doc.css("div#download a")[2]['href'].gsub(/\s+/, "")

        req = Net::HTTP::Get.new('/search/admin/analytics/' + chart_url)
        req.basic_auth ENV['FUNNELBACK_USERNAME'], ENV['FUNNELBACK_PASSWORD']
        response = @http.request(req)

        open(@output_location + usage_chart_filename, "wb") { |file|
            file.write(response.body)
        }

    end

    def fetch_funnelback_content(report_url, output_filename)

        # report_url = "/search/admin/analytics/Dashboard?collection=website&time=tq&timeframe=day&startDate=20131212&endDate=20140312"
        req = Net::HTTP::Get.new(report_url)
        req.basic_auth(ENV['FUNNELBACK_USERNAME'], ENV['FUNNELBACK_PASSWORD'])
        response = @http.request(req)

        # Save to disk so that Nokogiri can view it
        open(@output_location + FUNNELBACK_REPORT_HTML, "wb") { |file|
            file.write(response.body)
        }

        report_page = File.open(@output_location + FUNNELBACK_REPORT_HTML)
        @doc = Nokogiri::HTML(report_page)
        report_page.close

    end

end


