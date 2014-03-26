class CreateMoods < ActiveRecord::Migration
  def change
    create_table :moods do |t|
      t.text :user_mood
      t.string :stored_sentiment
      t.float :score

      t.timestamps
    end
  end
end
