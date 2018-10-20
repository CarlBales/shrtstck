require 'test_helper'

class ShortenedLinksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shortened_link = shortened_links(:one)
  end

  test "should get index" do
    get shortened_links_url
    assert_response :success
  end

  test "should get new" do
    get new_shortened_link_url
    assert_response :success
  end

  test "should create shortened_link" do
    assert_difference('ShortenedLink.count') do
      post shortened_links_url, params: { shortened_link: { is_expired: @shortened_link.is_expired, original_url: @shortened_link.original_url, short_url_slug: @shortened_link.short_url_slug, visit_count: @shortened_link.visit_count } }
    end

    assert_redirected_to shortened_link_url(ShortenedLink.last)
  end

  test "should show shortened_link" do
    get shortened_link_url(@shortened_link)
    assert_response :success
  end

  test "should get edit" do
    get edit_shortened_link_url(@shortened_link)
    assert_response :success
  end

  test "should update shortened_link" do
    patch shortened_link_url(@shortened_link), params: { shortened_link: { is_expired: @shortened_link.is_expired, original_url: @shortened_link.original_url, short_url_slug: @shortened_link.short_url_slug, visit_count: @shortened_link.visit_count } }
    assert_redirected_to shortened_link_url(@shortened_link)
  end

  test "should destroy shortened_link" do
    assert_difference('ShortenedLink.count', -1) do
      delete shortened_link_url(@shortened_link)
    end

    assert_redirected_to shortened_links_url
  end
end
