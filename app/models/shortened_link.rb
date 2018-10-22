class ShortenedLink < ApplicationRecord

    validates :original_url, presence: true, on: :create
    validates_format_of :original_url, with: /\A(?:(?:http|https):\/\/)?([-a-zA-Z0-9.]{2,256}\.[a-z]{2,4})\b(?:\/[-a-zA-Z0-9@,!:%_\+.~#?&\/\/=]*)?\z/
    validates_uniqueness_of :short_url_slug
    before_validation :set_default_values, :sanitize_original_url, on: :create

    # Regex:
    # for validates_format_of (http[s] optional)
    # /\A(?:(?:http|https):\/\/)?([-a-zA-Z0-9.]{2,256}\.[a-z]{2,4})\b(?:\/[-a-zA-Z0-9@,!:%_\+.~#?&\/\/=]*)?\z/
    # for http prepend in sanitize_original_url
    # /\Ahttps?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)\z/

    protected
    # Set the default vaules for a new shortened link
    ## short_url_slug to be a 6 digit alpha numeric validated to be unique.
    ## visit_count set to 0, increments after every show
    ## is_expired to be set to true in edit by the end user. if true, filter from index list..
    def set_default_values
        self.short_url_slug     = rand(36**6).to_s(36)
        self.visit_count        = 0
        self.is_expired         = false
        # TODO: Need to retry for random generation of short_url slug, odds are pretty solid for no dups, but just in case it shouldnt fail outright.
    end

    def sanitize_original_url
        self.original_url = self.original_url.prepend('http://') unless /\Ahttps?\:\/\/.+\z/ =~ self.original_url
    end
end
