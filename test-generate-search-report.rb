require_relative 'generate_search_report'
require 'minitest/autorun'
require 'fileutils'


class TestGenerateFunnelbackReport < MiniTest::Unit::TestCase


  def setup
    @output_location = "testoutput"
    # TODO this would be better if the URL was hidden in the initialiser, and took date range
    @funnelback_quarterly_report_url = "/search/admin/analytics/Dashboard?collection=website&time=tq&timeframe=day&startDate=20131212&endDate=20140312"
    @funnelback_top_queries_chart_url = "/search/admin/analytics/Dashboard?startDate=20140101T000000&endDate=20140401T000000&time=p&timeframe=quarter&collection=website&profile=&from=outliers&r=SUMMARY"
    @generator = GenerateFunnelbackReport.new(@output_location)
    # should probably check that output_location is empty
  end

  def teardown
    FileUtils.rm_r(@output_location)
  end

  def test_monthly_usage_exists
    @generator.fetch_monthly_usage(@funnelback_quarterly_report_url)
    assert(File.exists?(@output_location + "/" + @generator.get_monthly_usage_filename))
  end

  def test_usage_chart_exists
    @generator.fetch_usage_chart(@funnelback_top_queries_chart_url)
    assert(File.exists?(@output_location + "/" + @generator.get_usage_chart_filename))
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