require 'net/http'
require 'net/https'
require 'fileutils'

require 'nokogiri'
require 'open-uri'

# require 'sinatra'

class GenerateFunnelbackReport

    FUNNELBACK_REPORT_HTML = "report.html"
    MONTHLY_USAGE_FILENAME = "monthly-usage-table.html"

    def initialize(output_location)
        if !output_location.end_with? "/"
            output_location = output_location + "/"
        end

        @output_location = output_location
        if !File.exists?(@output_location)
            FileUtils.mkdir(@output_location)
        end

    end

    def fetch_monthly_usage(report_url)
        self.fetch_funnelback_content(report_url, MONTHLY_USAGE_FILENAME)

        monthly_usage_table = @doc.css('div.summary_report table')[0]
        open(@output_location + MONTHLY_USAGE_FILENAME, "wb") { |file|
            file.write(monthly_usage_table)
        }
    end

    def get_monthly_usage_filename
        MONTHLY_USAGE_FILENAME
    end


    def fetch_funnelback_content(url, output_filename)

        # Set up HTTP client to get report page and get past HTTP Auth
        http = Net::HTTP.new(ENV['FUNNELBACK_URL'],8443)
        report_url = "/search/admin/analytics/Dashboard?collection=website&time=tq&timeframe=day&startDate=20131212&endDate=20140312"
        req = Net::HTTP::Get.new(report_url)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        req.basic_auth(ENV['FUNNELBACK_USERNAME'], ENV['FUNNELBACK_PASSWORD'])
        response = http.request(req)

        # Save to disk so that Nokogiri can view it
        open(@output_location + FUNNELBACK_REPORT_HTML, "wb") { |file|
            file.write(response.body)
        }

        report_page = File.open(@output_location + FUNNELBACK_REPORT_HTML)
        @doc = Nokogiri::HTML(report_page)
        report_page.close

        # Attempt to get the Usage summary chart
        # Go to page that has chart and link to download
        # req = Net::HTTP::Get.new('/search/admin/analytics/Dashboard?startDate=20140101T000000&endDate=20140401T000000&time=p&timeframe=quarter&collection=website&profile=&from=outliers&r=SUMMARY')
        # req.basic_auth ENV['FUNNELBACK_USERNAME'], ENV['FUNNELBACK_PASSWORD']
        # response = http.request(req)

        # open("snippets/usage-summary-chart.html", "wb") { |file|
        #     file.write(response.body)
        # }


        # chart_page = File.open("snippets/usage-summary-chart.html")
        # chart_doc = Nokogiri::HTML(chart_page)
        # chart_page.close

        # chart_url = chart_doc.css("div#download a")[2]['href'].gsub(/\s+/, "")

        # req = Net::HTTP::Get.new('/search/admin/analytics/' + chart_url)
        # req.basic_auth ENV['FUNNELBACK_USERNAME'], ENV['FUNNELBACK_PASSWORD']
        # response = http.request(req)

        # open("assets/usage-summary-chart.png", "wb") { |file|
        #     file.write(response.body)
        # }

        # Look at the rest of the report

    end

end


