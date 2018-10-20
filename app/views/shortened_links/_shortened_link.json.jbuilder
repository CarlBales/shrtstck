json.extract! shortened_link, :id, :original_url, :short_url_slug, :visit_count, :is_expired, :created_at, :updated_at
json.url shortened_link_url(shortened_link, format: :json)
