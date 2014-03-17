require_relative 'generate_search_report'
require 'minitest/autorun'
require 'fileutils'
require 'nokogiri'


class TestGenerateFunnelbackReport < MiniTest::Unit::TestCase


  def setup
    # TODO this would be better if the URL was hidden in the initialiser, and took date range
    @funnelback_quarterly_report_url = "/search/admin/analytics/Dashboard?collection=website&time=tq&timeframe=day&startDate=20131212&endDate=20140312"
    @funnelback_top_queries_chart_url = "/search/admin/analytics/Dashboard?startDate=20140101T000000&endDate=20140401T000000&time=p&timeframe=quarter&collection=website&profile=&from=outliers&r=SUMMARY"
    @funnelback_queries_per_hour_chart_url = "/search/admin/analytics/Dashboard?collection=website&time=l90d&timeframe=day&startDate=20131217&endDate=20140317&r=QUERIES_PER_HOUR"
    @generator = GenerateFunnelbackReport.new("testoutput")
    # should probably check that output_location is empty
  end

  def teardown
    FileUtils.rm_r(@generator.output_location)
  end

  def test_image_paths_alter
    # Tests that paths have been changed from "../images" to "images"
    @generator.fetch_monthly_usage(@funnelback_quarterly_report_url)
    report_page = File.open(@generator.output_location + @generator.monthly_usage_filename)
    doc = Nokogiri::HTML(report_page)
    report_page.close
    assert(doc)
    image_path = doc.css('img')[0]['src']
    assert(image_path, "Didn't find an img tag")
    assert(image_path.match(/^images/), "Img src path isn't right")
  end

  def test_all_report_exists
    @generator.fetch_all_report(@funnelback_quarterly_report_url)
    assert(File.exists?(@generator.output_location + "/" + @generator.all_report_filename))
  end

  def test_remove_more_links
    @generator.fetch_all_report(@funnelback_quarterly_report_url)
    report_page = File.open(@generator.output_location + @generator.all_report_filename)
    doc = Nokogiri::HTML(report_page)
    report_page.close
    assert(doc)
    more_links = doc.css('a.more_link')
    puts more_links
    assert(more_links.count == 0, "There should be no 'more' links, but I found some")
  end

  def test_monthly_usage_exists
    @generator.fetch_monthly_usage(@funnelback_quarterly_report_url)
    assert(File.exists?(@generator.output_location + "/" + @generator.monthly_usage_filename))
  end

  def test_usage_chart_exists
    @generator.fetch_usage_chart(@funnelback_top_queries_chart_url)
    assert(File.exists?(@generator.output_location + "/" + @generator.usage_chart_filename))
  end

  def test_queries_per_hour_chart_exists
    @generator.fetch_queries_per_hour_chart(@funnelback_queries_per_hour_chart_url)
    assert(File.exists?(@generator.output_location + "/" + @generator.queries_per_hour_filename))
  end

  # def test_top_queries_chart_exists

  # end


  # def test_result_clicks_exists
  #   flunk("test hasn't been written yet")
  # end

  # def test_searches_with_no_results_exists
  #   flunk("test hasn't been written yet")
  # end

  # def test_best_bet_clicks_exists
  #   flunk("test hasn't been written yet")
  # end

  # def test_top_cities_exists
  #   flunk("test hasn't been written yet")
  # end

  # def test_pattern_analyser_exists
  #   flunk("test hasn't been written yet")
  # end

end