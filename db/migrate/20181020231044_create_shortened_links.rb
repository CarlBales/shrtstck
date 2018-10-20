class CreateShortenedLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :shortened_links do |t|
      t.text :original_url
      t.string :short_url_slug
      t.integer :visit_count
      t.boolean :is_expired

      t.timestamps
    end
  end
end
