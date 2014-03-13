require_relative 'generate_search_report'
require 'minitest/autorun'


class TestGenerateFunnelbackReport < MiniTest::Unit::TestCase

  def setup
    @generator = GenerateFunnelbackReport.new(output_location)
    # should probably check that output_location is empty
  end

  def test_monthly_usage_exists
  	@generator.fetch_funnelback_content(monthly_usage_url)
  	assert(File.exist?(output_location + @generator.MONTHLY_USAGE_FILENAME))
  end

  def test_top_queries_chart_exists
  	flunk("test hasn't been written yet")
  end

  def test_result_clicks_exists
  	flunk("test hasn't been written yet")
  end

  def test_searches_with_no_results_exists
  	flunk("test hasn't been written yet")
  end

  def test_best_bet_clicks_exists
  	flunk("test hasn't been written yet")
  end

  def test_top_cities_exists
  	flunk("test hasn't been written yet")
  end

  def test_pattern_analyser_exists
  	flunk("test hasn't been written yet")
  end

end