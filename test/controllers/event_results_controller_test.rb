require 'test_helper'

class EventResultsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event_result = event_results(:one)
  end

  test "should get index" do
    get event_results_url
    assert_response :success
  end

  test "should get new" do
    get new_event_result_url
    assert_response :success
  end

  test "should create event_result" do
    assert_difference('EventResult.count') do
      post event_results_url, params: { event_result: {  } }
    end

    assert_redirected_to event_result_url(EventResult.last)
  end

  test "should show event_result" do
    get event_result_url(@event_result)
    assert_response :success
  end

  test "should get edit" do
    get edit_event_result_url(@event_result)
    assert_response :success
  end

  test "should update event_result" do
    patch event_result_url(@event_result), params: { event_result: {  } }
    assert_redirected_to event_result_url(@event_result)
  end

  test "should destroy event_result" do
    assert_difference('EventResult.count', -1) do
      delete event_result_url(@event_result)
    end

    assert_redirected_to event_results_url
  end
end
